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
import OTPGenerator from '../utils/otp-generator'
// import SupplyStub from '../services/supply.service'

const supplies = DummyData.supplies;
// const vehicleData = DummyData.vehicles
// const serviceData = DummyData.services
// const supplyClient = SupplyStub.client()

class DriverController implements IController {
    readonly path: string = '/driver'
    readonly router: Router = Router()

    constructor() {
        this.router.get('/create-db', catchAsync(this.createDB))
        this.router.get('/delete-db', catchAsync(this.deleteDB))
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
        this.router.post('/register', catchAsync(this.register))
        this.router.post('/verify-user-registration', catchAsync(this.verifyUserRegistration))
        this.router.post('/resend-otp', catchAsync(this.resendOTP))
    }

    private async uploadFile(req: Request, res: Response, next: NextFunction) {
        // test multer
        Logger.info(req.file)
        Logger.info(req.cloudinaryResult)
        return res.status(200).json({ message: 'ok' })
    }

    private async register(req: Request, res: Response, next: NextFunction) {
        // test multer
        const getDriverFromDB = await DriverModel.find();
        await DriverModel.create({
            id: getDriverFromDB.length + 1,
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            // phoneNumber: req.body.phoneNumber,
            // password: req.body.password,
            // passwordConfirm: req.body.passwordConfirm
        })
        // const otp = new OTPGenerator().generate();
        const otp = '123'
        return res.status(200).json({ otp: otp, message: 'Please input OTP code to verify account' })
    }

    private async verifyUserRegistration(req: Request, res: Response, next: NextFunction) {
        if (req.body.otp === '123456') {
            return res.status(200).json({
                message: "Register successfully",
            })
        }
        else {
            return res.status(401).json({
                message: "Invalid OTP, please try again!"
            })
        }
    }

    private resendOTP = async (req: Request, res: Response, next: NextFunction) => {
        // check if phone number exists
        // const getDriver = await DriverModel.findOne({ phoneNumber: req.body.phoneNumber });

        // if (!getDriver || !(getDriver.email === req.body.phoneNumber)) {
        //     return res.status(401).json({
        //         message: "This phone number does not exist!"
        //     })
        // }

        const otp = '123456'

        // const htmlToSend = template(replacements);
        // await GMailer.sendMail({
        //     to: req.body.email,
        //     subject: 'Verify your account',
        //     html: htmlToSend,
        // });

        return res.status(200).json({
            message: "We've sent a new OTP to your phone",
            otp: otp,
        })
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