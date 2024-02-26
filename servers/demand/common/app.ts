import dotenv from 'dotenv'
dotenv.config({ path: './.env' })

import express from 'express'
import mongoose from 'mongoose'
import morgan from 'morgan'
import cors from 'cors'
import cookieParser from 'cookie-parser'
import path from 'path'
import fs from 'fs'
import { Server } from 'http'
import { Socket } from 'socket.io'
import chalk from 'chalk'
import IController from './interfaces/controller'
import ErrorFactoryHandler from './middlewares/error.middleware'
import CorsCustomOptions from './configs/cors.config'
import socketIO from './socket'
import IEvent from './interfaces/event'
import mimes from './constants/mimes'
import AppError from './services/errors/app.error'
import credentials from './middlewares/credential.middleware'
import redis from './services/redis'
import cloudinary from './services/cloudinary'
import { ConfigOptions } from 'cloudinary'
import Logger from './utils/logger'
import gRPC from './services/grpc'
import SupplyStub from './services/supply.service'

type MongoConnection = {
    uri: string
    options?: mongoose.ConnectOptions
}

type RedisConnection = {
    uri: string
}

type ApplicationOptions = {
    controllers: IController[]
    events: IEvent[]
    mongoConnection: MongoConnection
    redisConnection: RedisConnection
    cloudinaryConnection: ConfigOptions
}

class Application {
    private app: express.Application
    private appName: string
    private appVersion: string

    private controllers: IController[] = []
    private events: IEvent[] = []

    private mongoConnection: MongoConnection
    private redisConnection: RedisConnection
    private cloudinaryConnection: ConfigOptions

    private rabbitRetry: number = 5

    constructor(options: ApplicationOptions) {
        this.app = express()

        this.controllers = options.controllers
        this.events = options.events

        this.redisConnection = options.redisConnection
        this.mongoConnection = options.mongoConnection
        this.cloudinaryConnection = options.cloudinaryConnection

        this.appName = `[${process.env.APP_NAME}]`
        this.appVersion = `${process.env.APP_VERSION}`

        this.redisConnect(this.redisConnection.uri)
        this.mongoDBConnect(
            this.mongoConnection.uri,
            this.mongoConnection.options
        )

        this.setup()
    }

    public application() {
        return this.app
    }

    private setup() {
        this.app.enable('trust proxy')

        Logger.info(chalk.yellow('Setting up server...'))

        this.app.use(credentials)
        this.app.use(cors(CorsCustomOptions))
        this.app.use(cloudinary.config(this.cloudinaryConnection))

        this.app.use(express.json({ limit: '50mb' }))
        this.app.use(express.urlencoded({ extended: true }))
        this.app.use(cookieParser())

        this.app.use(
            morgan(
                `${chalk.blue(this.appName)}${chalk.yellow('[:date]')} ${chalk.green(':method')} ${chalk.cyan(
                    ':status'
                )} ${chalk.white(':url')} :res[content-length] - :response-time ms`
            )
        )

        this.controllers.forEach((controller) => {
            this.app.use(
                `/${this.appVersion}${controller.path}`,
                controller.router
            )
        })

        this.app.get('/status', (req, res) => {
            return res.json({
                server: this.appName.replace(/\[(.*)\]/, '$1'),
                status: '200 - OK',
                message: 'Server is running ...',
            })
        })

        this.app.all('*', (req, res, next) => {
            const file = path.join(__dirname, req.path)
            const type: string = mimes[path.extname(file).slice(1)]

            if (type) {
                const s = fs.createReadStream(file)

                s.on('open', () => {
                    res.set('Content-Type', type)
                    s.pipe(res)
                })

                s.on('error', () => {
                    return next(
                        new AppError(
                            `Can't find ${req.originalUrl} on this server!`,
                            404
                        )
                    )
                })
            } else {
                return next(
                    new AppError(
                        `Can't find ${req.originalUrl} on this server!`,
                        404
                    )
                )
            }
        })

        this.app.use(ErrorFactoryHandler)
    }

    private mongoDBConnect(
        uri: string,
        options: mongoose.ConnectOptions = {}
    ): void {
        mongoose
            .connect(uri, options)
            .then(() => {
                Logger.info(chalk.green('Connected to database successfully'))
            })
            .catch((error) => {
                Logger.error('Could not connect to the database', error)
            })
    }

    private redisConnect(uri: string) {
        redis
            .connect(uri)
            .then(() => {
                Logger.info(chalk.green('Connected to redis successfully'))
            })
            .catch((error: Error) => {
                Logger.error('Could not connect to the redis', error)
            })
    }

    public run(callback: () => void = () => {}): Server {
        Logger.info(chalk.blue('Server is starting...'))

        const availablePort = process.env.APP_PORT ?? 3000

        const server: Server = this.app.listen(availablePort, async () => {
            Logger.info(
                chalk.green(
                    `Server is running on port ${chalk.cyan(availablePort)}`
                )
            )

            gRPC.start()

            SupplyStub.connect()

            socketIO.init(server)

            const io = socketIO.getIO()

            io.on('connection', (socket: Socket) => {
                Logger.info(`Connection details - Socket ID: ${socket.id}`)

                this.events.forEach((event) => {
                    socket.on(event.event, (...args: any[]) =>
                        event.listener(io, socket, ...args)
                    )
                })
            })

            callback()
        })

        return server
    }
}

export default Application
