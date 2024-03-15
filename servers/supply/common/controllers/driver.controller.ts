import mongoose from 'mongoose'
import { NextFunction, Request, Response, Router } from 'express'
import IController from '../interfaces/controller'
import DriverModel from '../models/driver.model'
import catchAsync from '../utils/catch.error'
import DTOValidation from '../middlewares/validation.middleware'
import UserDTO from '../dtos/user.example.dto'
import Jwt, { JsonWebToken } from '../utils/jwt'
import GMailer from '../services/mailer.builder'
import cacheMiddleware from '../middlewares/cache.middleware'
import redis from '../services/redis'
import MulterCloudinaryUploader from '../multer'
import Logger from '../utils/logger'
import * as DummyData from '../dummy_data/dummy_data'
import OTPGenerator from '../utils/otp-generator'
import AdminStub from '../services/admin.service'
import AppError from '../services/errors/app.error'
import { PHONENUMER_REGEX } from '../constants/regex'
import firebase from '../firebase/firebase'

// import SupplyStub from '../services/supply.service'

const supplies = DummyData.supplies
// const vehicleData = DummyData.vehicles
// const serviceData = DummyData.services
// const supplyClient = SupplyStub.client()

const adminClient = AdminStub.client()

class DriverController implements IController {
    readonly path: string = '/driver'
    readonly router: Router = Router()

    constructor() {
        this.router.get('/create-db', catchAsync(this.createDB))
        this.router.get('/delete-db', catchAsync(this.deleteDB))
        this.router.post('/register', catchAsync(this.register))
        this.router.post('/google', catchAsync(this.googleValidate))
        this.router.post('/phone', catchAsync(this.phoneValidate))
        this.router.post(
            '/verify-user-registration',
            catchAsync(this.verifyUserRegistration)
        )
        this.router.post('/resend-otp', catchAsync(this.resendOTP))

        this.router.post('/update-service', catchAsync(this.updateService))
        this.router.post('/update-address', catchAsync(this.updateAddress))
        this.router.post('/update-email', catchAsync(this.updateEmail))
        this.router.post('/update-vehicle', catchAsync(this.updateVehicle))
        this.router.post(
            '/update-identity-info',
            catchAsync(this.updateIdentityInfo)
        )

        this.router.post('/submit-driver', catchAsync(this.submitDriver))

        const multercloud = new MulterCloudinaryUploader(
            ['jpg', 'jpeg', 'png', 'gif'],
            5 * 1024 * 1024
        )

        this.router.post(
            '/upload/personal-img',
            multercloud.single('image'),
            multercloud.uploadCloud('personal-img'),
            catchAsync(this.uploadPersonalImg)
        )

        this.router.post(
            '/upload/driver-license-frontsight',
            multercloud.single('image'),
            multercloud.uploadCloud('driver-license'),
            catchAsync(this.uploadDriverLicenseFrontsight)
        )
        this.router.post(
            '/upload/driver-license-backsight',
            multercloud.single('image'),
            multercloud.uploadCloud('driver-license'),
            catchAsync(this.uploadDriverLicenseBacksight)
        )

        this.router.post(
            '/upload/identity-img-frontsight',
            multercloud.single('image'),
            multercloud.uploadCloud('identity-img'),
            catchAsync(this.uploadIdentityImgFrontsight)
        )
        this.router.post(
            '/upload/identity-img-backsight',
            multercloud.single('image'),
            multercloud.uploadCloud('identity-img'),
            catchAsync(this.uploadIdentityImgBacksight)
        )

        this.router.post(
            '/upload/vehicle-img-frontsight',
            multercloud.single('image'),
            multercloud.uploadCloud('vehicle-img'),
            catchAsync(this.uploadVehicleImgFrontsight)
        )
        this.router.post(
            '/upload/vehicle-img-backsight',
            multercloud.single('image'),
            multercloud.uploadCloud('vehicle-img'),
            catchAsync(this.uploadVehicleImgBacksight)
        )
        this.router.post(
            '/upload/vehicle-img-leftsight',
            multercloud.single('image'),
            multercloud.uploadCloud('vehicle-img'),
            catchAsync(this.uploadVehicleImgLeftsight)
        )
        this.router.post(
            '/upload/vehicle-img-rightsight',
            multercloud.single('image'),
            multercloud.uploadCloud('vehicle-img'),
            catchAsync(this.uploadVehicleImgRightsight)
        )

        this.router.post(
            '/upload/vehicle-registration-frontsight',
            multercloud.single('image'),
            multercloud.uploadCloud('vehicle-registration'),
            catchAsync(this.uploadVehicleRegistrationFrontsight)
        )
        this.router.post(
            '/upload/vehicle-registration-backsight',
            multercloud.single('image'),
            multercloud.uploadCloud('vehicle-registration'),
            catchAsync(this.uploadVehicleRegistrationBacksight)
        )

        this.router.post(
            '/upload/vehicle-insurance-frontsight',
            multercloud.single('image'),
            multercloud.uploadCloud('vehicle-insurance'),
            catchAsync(this.uploadVehicleInsuranceFrontsight)
        )
        this.router.post(
            '/upload/vehicle-insurance-backsight',
            multercloud.single('image'),
            multercloud.uploadCloud('vehicle-insurance'),
            catchAsync(this.uploadVehicleInsuranceBacksight)
        )
    }

    private async googleValidate(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const googleId = req.body.googleId

        if (
            !req.headers.authorization ||
            req.headers.authorization.indexOf('Bearer') === -1 ||
            !googleId
        )
            return next(new AppError('Bad Request', 400))

        const token = req.headers.authorization.replace('Bearer ', '')
        const decodedGoogleUser = await firebase.auth().verifyIdToken(token)

        if (!decodedGoogleUser)
            return next(new AppError('Account has not been available', 404))

        const driverWithGoogle = await DriverModel.findOne({
            googleId: googleId,
            email: decodedGoogleUser.email,
        })

        if (
            driverWithGoogle &&
            driverWithGoogle.phoneNumber &&
            driverWithGoogle.phoneNumber !== '' &&
            PHONENUMER_REGEX.test(driverWithGoogle.phoneNumber) === true
        ) {
            if (driverWithGoogle.verified) {
                return res.status(200).json({
                    message: 'Account has been verified',
                    step: 'OTP',
                    data: driverWithGoogle,
                })
            }

            try {
                const getAprrovals = await adminClient.findApprovalById(
                    driverWithGoogle.id
                )

                if (getAprrovals.serviceID && getAprrovals.serviceID !== '') {
                    return res.status(200).json({
                        message:
                            'Account has been registered but has not applied yet',
                        step: 'INFO',
                        data: driverWithGoogle,
                    })
                }

                return res.status(200).json({
                    message:
                        'Account has been registered but has not chosen service yet',
                    step: 'OTP',
                    data: driverWithGoogle,
                })
            } catch (_) {
                return res.status(200).json({
                    message:
                        'Account has been registered but has not chosen service yet',
                    step: 'OTP',
                    data: driverWithGoogle,
                })
            }
        }

        return res.status(200).json({
            message: 'Account has not been registered yet',
            step: 'REGISTER',
        })
    }

    private async phoneValidate(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const phonenumber = req.body.phone

        if (
            !req.headers.authorization ||
            req.headers.authorization.indexOf('Bearer') === -1 ||
            !phonenumber
        )
            return next(new AppError('Bad Request', 400))

        const token = req.headers.authorization.replace('Bearer ', '')
        const decodedPhoneUser = await firebase.auth().verifyIdToken(token)

        if (
            !decodedPhoneUser?.phone_number ||
            phonenumber !== decodedPhoneUser.phone_number
        )
            return next(new AppError('Account has not been available', 404))

        const driverWithGoogle = await DriverModel.findOne({
            phoneNumber: `0${decodedPhoneUser.phone_number.substring(3)}`,
        }).lean()

        if (
            driverWithGoogle &&
            driverWithGoogle.phoneNumber &&
            driverWithGoogle.phoneNumber !== '' &&
            PHONENUMER_REGEX.test(driverWithGoogle.phoneNumber) === true
        ) {
            if (driverWithGoogle.verified) {
                return res.status(200).json({
                    message: 'Account has been verified',
                    step: 'HOME',
                    data: driverWithGoogle,
                })
            }

            try {
                const getAprrovals = await adminClient.findApprovalById(
                    driverWithGoogle.id
                )

                if (getAprrovals.serviceID && getAprrovals.serviceID !== '') {
                    return res.status(200).json({
                        message:
                            'Account has been registered but has not applied yet',
                        step: 'INFO',
                        data: {
                            ...driverWithGoogle,
                            serviceID: getAprrovals.serviceID,
                            vehicleID: getAprrovals.vehicleID,
                            status: getAprrovals.status,
                        },
                    })
                } else if (
                    !getAprrovals.serviceID ||
                    getAprrovals.serviceID === ''
                ) {
                    return res.status(200).json({
                        message:
                            'Account has been registered but has not chosen service yet',
                        step: 'SERVICE',
                        data: {
                            ...driverWithGoogle,
                            serviceID: getAprrovals.serviceID,
                            vehicleID: getAprrovals.vehicleID,
                            status: getAprrovals.status,
                        },
                    })
                }
            } catch (_) {
                return res.status(200).json({
                    message: 'Account has not been registered yet',
                    step: 'REGISTER',
                    data: null,
                })
            }
        }

        return res.status(200).json({
            message: 'Account has not been registered yet',
            step: 'REGISTER',
            data: null,
        })
    }

    private async register(req: Request, res: Response, next: NextFunction) {
        // test multer
        const getNumOfDriverWithCurrentPhoneNumber = (
            await DriverModel.find({ phoneNumber: req.body.phoneNumber })
        ).length
        if (getNumOfDriverWithCurrentPhoneNumber !== 0) {
            return res.status(401).json({
                message:
                    'Phone number has been existed, please register with different phone number',
            })
        } else {
            if (
                !req.headers.authorization ||
                req.headers.authorization.indexOf('Bearer') === -1
            )
                return next(new AppError('Bad Request', 400))

            const token = req.headers.authorization.replace('Bearer ', '')
            const decodedGoogleUser = await firebase.auth().verifyIdToken(token)

            if (!decodedGoogleUser?.email)
                return next(new AppError('Token has been expired', 401))

            const getDrivers = await DriverModel.find()
            const maxId = Math.max(...getDrivers.map((el) => parseInt(el.id)))

            const newDriver = new DriverModel({
                id: `${maxId + 1}`,
                firstName: req.body.firstName,
                lastName: req.body.lastName,
                phoneNumber: req.body.phoneNumber,
                password:
                    '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
                dob: '',
                gender: '',
                address: '',
                verified: false,
                avatar: '',
                email: decodedGoogleUser.email,
                referralCode: req.body.referralCode,
                city: req.body.city,
                googleId: decodedGoogleUser.uid,
            })

            const driver = await newDriver.save()

            if (driver) {
                await adminClient.createServiceApproval((maxId + 1).toString())

                return res.status(200).json({
                    message: 'Please input OTP code to verify account',
                    data: driver,
                })
            }

            return res.status(400).json({
                message: 'Bad request',
            })
        }
    }

    private async verifyUserRegistration(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const services = await adminClient.getServices()
        return res.status(200).json({
            message: 'Register successfully',
            data: services,
        })
    }

    private resendOTP = async (
        req: Request,
        res: Response,
        next: NextFunction
    ) => {
        // check if phone number exists
        const getDriver = await DriverModel.findOne({
            phoneNumber: req.body.phoneNumber,
        })

        if (!getDriver || !(getDriver.phoneNumber === req.body.phoneNumber)) {
            return res.status(401).json({
                message: 'This phone number does not exist!',
            })
        }

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

    private async updateService(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'serviceID',
            req.body.serviceId
        )
        return res.status(200).json({
            message: 'Update service successfully',
        })
    }

    private async updateAddress(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'currentAddress',
            req.body.currentAddress
        )
        await DriverModel.updateOne(
            { id: req.body.id },
            { address: req.body.currentAddress }
        )
        return res.status(200).json({
            message: 'Update address successfully',
        })
    }

    private async updateEmail(req: Request, res: Response, next: NextFunction) {
        await DriverModel.updateOne(
            { id: req.body.id },
            { email: req.body.email }
        )
        return res.status(200).json({
            message: 'Update email successfully',
        })
    }

    private async updateVehicle(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.createVehicleInformation(
            req.body.id,
            req.body.name,
            req.body.identityNumber,
            req.body.color,
            req.body.brand
        )
        return res.status(200).json({ message: 'Update vehicle successfully' })
    }

    private async updateIdentityInfo(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateIdentityInfo(
            req.body.id,
            req.body.identityDate,
            req.body.identityLocation
        )
        return res.status(200).json({
            message: 'Update identity info successfully',
        })
    }

    private async submitDriver(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const getDriverById = await DriverModel.findOne({ id: req.body.id })

        if (getDriverById && getDriverById.email !== '') {
            await GMailer.sendMail({
                to: getDriverById.email,
                subject: 'Trạng thái hồ sơ',
                html: '<h3>Chúng tôi đã nhận được hồ sơ của bạn, vui lòng chờ quản trị viên phê duyệt</h3>',
            })
            return res.status(200).json({
                message:
                    'We have received your profile, please wait for admin to approve your profile',
            })
        } else {
            return res
                .status(401)
                .json({ message: 'Please link email to your account' })
        }
    }

    private async createDB(req: Request, res: Response, next: NextFunction) {
        for await (const supply of supplies) {
            await DriverModel.create(supply)
        }

        return res.status(200).json({ data: 'Create data successfully' })
    }

    private async deleteDB(req: Request, res: Response, next: NextFunction) {
        await DriverModel.deleteMany()

        return res.status(200).json({ data: 'Delete data successfully' })
    }

    private async uploadPersonalImg(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'personalImg',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        await DriverModel.updateOne(
            { id: req.body.id },
            {
                avatar:
                    req.cloudinaryResult.secure_url || req.cloudinaryResult.url,
            }
        )
        return res.status(200).json({ message: 'Upload avatar successfully' })
    }

    private async uploadDriverLicenseFrontsight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'driverLicenseFrontsight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res
            .status(200)
            .json({ message: 'Upload driver license frontsight successfully' })
    }

    private async uploadDriverLicenseBacksight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'driverLicenseBacksight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res
            .status(200)
            .json({ message: 'Upload driver license backsight successfully' })
    }

    private async uploadIdentityImgFrontsight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'identityImgFrontsight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res
            .status(200)
            .json({ message: 'Upload identity img frontsight successfully' })
    }

    private async uploadIdentityImgBacksight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'identityImgBacksight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res
            .status(200)
            .json({ message: 'Upload identity img backsight successfully' })
    }

    private async uploadVehicleImgFrontsight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'vehicleImgFrontsight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res
            .status(200)
            .json({ message: 'Upload vehicle img frontsight successfully' })
    }

    private async uploadVehicleImgBacksight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'vehicleImgBacksight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res
            .status(200)
            .json({ message: 'Upload vehicle img backsight successfully' })
    }

    private async uploadVehicleImgLeftsight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'vehicleImgLeftsight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res
            .status(200)
            .json({ message: 'Upload vehicle img leftsight successfully' })
    }

    private async uploadVehicleImgRightsight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'vehicleImgRightsight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res
            .status(200)
            .json({ message: 'Upload vehicle img rightsight successfully' })
    }

    private async uploadVehicleRegistrationFrontsight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'vehicleRegistrationFrontsight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res.status(200).json({
            message: 'Upload vehicle registration frontsight successfully',
        })
    }

    private async uploadVehicleRegistrationBacksight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'vehicleRegistrationBacksight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res.status(200).json({
            message: 'Upload vehicle registration backsight successfully',
        })
    }

    private async uploadVehicleInsuranceFrontsight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'vehicleInsuranceFrontsight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res.status(200).json({
            message: 'Upload vehicle insurance frontsight successfully',
        })
    }

    private async uploadVehicleInsuranceBacksight(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        await adminClient.updateServiceApproval(
            req.body.id,
            'vehicleInsuranceBacksight',
            req.cloudinaryResult.secure_url || req.cloudinaryResult.url
        )
        return res.status(200).json({
            message: 'Upload vehicle insurance backsight successfully',
        })
    }
}

export default new DriverController()
