import mongoose from 'mongoose'
import { NextFunction, Request, Response, Router } from 'express'
import IController from '../interfaces/controller'
import UserModel from '../models/user.example.model'
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

let data = [...DummyData.supplies];

class DriverController implements IController {
    readonly path: string = '/driver'
    readonly router: Router = Router()

    constructor() {
        this.router.get(
            '/',
            catchAsync(this.getServiceApprovals)
        )
        this.router.post(
            '/verify/:id',
            catchAsync(this.verifyDriver)
        )
        this.router.post(
            '/delete/:id',
            catchAsync(this.deleteDriver)
        )
        this.router.post(
            '/create',
            catchAsync(this.createDriver)
        )
    }

    private async getServiceApprovals (req: Request, res: Response, next: NextFunction) {
        return res.status(200).json({ data: data })
    }

    private async verifyDriver(req: Request, res: Response, next: NextFunction) {
        const index: number = data.findIndex(el => el.id === req.params.id);
        data[index].verified = !data[index].verified;
        return res.status(200).json({ data: data });
    }

    private async deleteDriver(req: Request, res: Response, next: NextFunction) {
        data = data.filter(el => el.id !== req.params.id);
        return res.status(200).json({ data: data });
    }

    private async createDriver(req: Request, res: Response, next: NextFunction) {
        const createData = {
            id: String(data.length + 1),
            ...req.body
        }
        data.push(createData);
        return res.status(200).json({ data: data});
    }

}

export default new DriverController()
