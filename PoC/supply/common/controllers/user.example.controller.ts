import mongoose from 'mongoose'
import { NextFunction, Request, Response, Router } from 'express'
import IController from '../interfaces/controller'
import UserModel from '../models/user.example.model'
import catchAsync from '../utils/catch.error'
import DTOValidation from '../middlewares/validation.middleware'
import UserDTO from '../dtos/user.example.dto'
import Jwt, { JsonWebToken } from '../utils/jwt'
import GMailer from '../services/mailer.builder'
import cacheMiddleware from '../middlewares/cache.middleware'
import redis from '../services/redis'
import MulterCloudinaryUploader from '../multer'
import Logger from '../utils/logger'

class UserController implements IController {
    readonly path: string = '/user'
    readonly router: Router = Router()

    public static profileCacheKey(req: Request): string {
        return `profile?id=${req.params.id}`
    }

    constructor() {
        // dto example
        this.router.post(
            '/',
            DTOValidation.validate<UserDTO>(UserDTO),
            catchAsync(this.createUser)
        )

        // extract 1 param example
        this.router.param('id', DTOValidation.extractParams(['id']))
        // cache example
        // this.router.get('/:id', cacheMiddleware(UserController.profileCacheKey), catchAsync(this.getUser));

        // extract params example
        this.router.get(
            '/details/:id/:idx',
            DTOValidation.extractParams(['id', 'idx']),
            catchAsync(this.getUser)
        )

        // upload file example
        const multercloud = new MulterCloudinaryUploader(
            ['jpg', 'jpeg', 'png', 'gif'],
            5 * 1024 * 1024
        )
        this.router.post(
            '/upload',
            multercloud.single('image'),
            multercloud.uploadCloud('uploads'),
            catchAsync(this.uploadFile)
        )
    }

    private async createUser(req: Request, res: Response, next: NextFunction) {
        // test dto validation.
        const userInfo = req.body as UserDTO
        Logger.info(userInfo)

        // c1
        // test jwt.
        Logger.info(
            'C1----------------------------------------------------------------'
        )
        const jwt = new JsonWebToken('this is my secret key')

        const token = await jwt.createToken(userInfo, {
            expiresIn: process.env.JWT_REFRESH_EXPIRES,
        })
        Logger.info(token)

        const payload = await jwt.verifyToken(token)
        Logger.info(payload)

        // c2
        Logger.info(
            'C2----------------------------------------------------------------'
        )

        const token2 = await Jwt.createToken(userInfo, {
            expiresIn: process.env.JWT_REFRESH_EXPIRES,
        })
        Logger.info(token2)

        const payload2 = await Jwt.verifyToken(token2)
        Logger.info(payload2)

        // sendmail example
        await GMailer.sendMail({
            to: userInfo.email,
            subject: 'Test send mail',
            html: '<h1>Hello World!</h1>',
        })

        // test error handler.
        const users = await UserModel.create(userInfo)

        return res.status(200).json(users)
    }

    private async getUser(req: Request, res: Response, next: NextFunction) {
        // test extract params
        Logger.info(req.body.id)
        Logger.info(req.body.idx)

        req.user = {
            _id: new mongoose.Types.ObjectId(123123),
            firstname: '123',
            lastname: '123',
            password: '123',
            email: '123',
        }

        // cache
        const redisClient = redis.getClient()
        await redisClient?.setEx(
            UserController.profileCacheKey(req),
            Number(process.env.REDIS_CACHE_EXPIRES),
            JSON.stringify(req.user)
        )

        return res.status(200).json({ message: req.user })
    }

    private async uploadFile(req: Request, res: Response, next: NextFunction) {
        // test multer
        Logger.info(req.file)
        Logger.info(req.cloudinaryResult)

        return res.status(200).json({ message: 'ok' })
    }
}

export default new UserController()
