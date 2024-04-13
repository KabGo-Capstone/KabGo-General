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
import { sendMessage } from 'common/utils/kafka'

class MessageController implements IController {
    readonly path: string = '/user'
    readonly router: Router = Router()

    public static profileCacheKey(req: Request): string {
        return `profile?id=${req.params.id}`
    }

    constructor() {
        // dto example
        this.router.post(
            '/demand-booking',
            catchAsync(this.handleBooking)
        )
    }

    private async handleBooking(req: Request, res: Response, next: NextFunction) {
        console.log(req.body);
        await sendMessage("demand-booking", JSON.stringify(req.body));
        return res.status(200).json({
            message: "message updated in demand booking topic successfully."
        })

        // return res.status(200).json(users)
    }
}

export default new MessageController()
