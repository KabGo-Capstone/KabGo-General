import mongoose from 'mongoose'
import { NextFunction, Request, Response, Router } from 'express'
import IController from '../interfaces/controller'
import DriverModel from '../models/driver.model'
import catchAsync from '../utils/catch.error'
import DTOValidation from '../middlewares/validation.middleware'
import UserDTO from '../dtos/user.example.dto'
import Jwt, { JsonWebToken } from '../utils/jwt'
// import GMailer from '../services/mailer.builder'
import cacheMiddleware from '../middlewares/cache.middleware'
import redis from '../services/redis'
import MulterCloudinaryUploader from '../multer'
import Logger from '../utils/logger'
import * as DummyData from '../dummy_data/dummy_data'
// import SupplyStub from '../services/supply.service'

const supplies = DummyData.supplies;
// const vehicleData = DummyData.vehicles
// const serviceData = DummyData.services
// const supplyClient = SupplyStub.client()

class DriverController implements IController {
    readonly path: string = '/driver'
    readonly router: Router = Router()

    constructor() {
        this.router.get('/create', catchAsync(this.createDB))
        this.router.get('/delete', catchAsync(this.deleteDB))
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

    private async uploadFile(req: Request, res: Response, next: NextFunction) {
        // test multer
        Logger.info(req.file)
        Logger.info(req.cloudinaryResult)
        return res.status(200).json({ message: 'ok' })
    }

    private async createDB(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        for await (const supply of supplies) {
            await DriverModel.create(supply);
        }

        return res.status(200).json({ data: 'Create data successfully' })
    }

    private async deleteDB(
        req: Request,
        res: Response,
        next: NextFunction
    ) {

        await DriverModel.deleteMany();

        return res.status(200).json({ data: 'Delete data successfully' })
    }

}

export default new DriverController()
