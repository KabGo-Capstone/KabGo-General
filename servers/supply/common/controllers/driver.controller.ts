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


// import SupplyStub from '../services/supply.service'

const supplies = DummyData.supplies;
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
        this.router.post('/verify-user-registration', catchAsync(this.verifyUserRegistration))
        this.router.post('/resend-otp', catchAsync(this.resendOTP))

        this.router.post('/update-service', catchAsync(this.updateService))
        this.router.post('/update-address', catchAsync(this.updateAddress))
        this.router.post('/update-email', catchAsync(this.updateEmail))
        this.router.post('/update-vehicle', catchAsync(this.updateVehicle))
        this.router.post('/update-identity-info', catchAsync(this.updateIdentityInfo))

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

    private async register(req: Request, res: Response, next: NextFunction) {
        // test multer
        const getNumOfDriverWithCurrentPhoneNumber = (await DriverModel.find({ phoneNumber: req.body.phoneNumber })).length;
        if (getNumOfDriverWithCurrentPhoneNumber !== 0) {
            return res.status(401).json({
                message: 'Phone number has been existed, please register with different phone number',
            })
        }
        else {
            const getDrivers = await DriverModel.find();
            const maxId = Math.max(...getDrivers.map(el => parseInt(el.id)))
            const createDriver = await DriverModel.create({
                id: (maxId + 1).toString(),
                firstName: req.body.firstName,
                lastName: req.body.lastName,
                phoneNumber: req.body.phoneNumber,
                password: "$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam",
                dob: "",
                gender: "",
                address: "",
                verified: false,
                avatar: "",
                email: "",
                referralCode: req.body.referralCode,
                city: req.body.city

            })

            await adminClient.createServiceApproval((maxId + 1).toString())

            // const otp = new OTPGenerator().generate();
            const otp = '123456'

            return res.status(200).json({
                otp: otp,
                message: 'Please input OTP code to verify account',
                data: createDriver
            })
        }
    }

    private async verifyUserRegistration(req: Request, res: Response, next: NextFunction) {
        if (req.body.otp === '123456') {
            const services = await adminClient.getServices();
            return res.status(200).json({
                message: "Register successfully",
                data: services
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
        const getDriver = await DriverModel.findOne({ phoneNumber: req.body.phoneNumber });

        if (!getDriver || !(getDriver.phoneNumber === req.body.phoneNumber)) {
            return res.status(401).json({
                message: "This phone number does not exist!"
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

    private async updateService(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'serviceID', req.body.serviceId)
        return res.status(200).json({
            message: 'Update service successfully',
        })
    }

    private async updateAddress(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'currentAddress', req.body.currentAddress)
        await DriverModel.updateOne({ id: req.body.id }, { address: req.body.currentAddress })
        return res.status(200).json({
            message: 'Update address successfully',
        })
    }

    private async updateEmail(req: Request, res: Response, next: NextFunction) {
        await DriverModel.updateOne({ id: req.body.id }, { email: req.body.email })
        return res.status(200).json({
            message: 'Update email successfully',
        })
    }

    private async updateVehicle(req: Request, res: Response, next: NextFunction) {
        await adminClient.createVehicleInformation(
            req.body.id,
            req.body.name,
            req.body.identityNumber,
            req.body.color,
            req.body.brand
        )
        return res.status(200).json({ message: 'Update vehicle successfully' })
    }

    private async updateIdentityInfo(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateIdentityInfo(req.body.id, req.body.identityDate, req.body.identityLocation)
        return res.status(200).json({
            message: 'Update identity info successfully',
        })
    }

    private async submitDriver(req: Request, res: Response, next: NextFunction) {

        const getDriverById = await DriverModel.findOne({ id: req.body.id });

        if (getDriverById && getDriverById.email !== '') {
            await GMailer.sendMail({
                to: getDriverById.email,
                subject: 'Trạng thái hồ sơ',
                html: '<h3>Chúng tôi đã nhận được hồ sơ của bạn, vui lòng chờ quản trị viên phê duyệt</h3>',
            });
            return res.status(200).json({ message: 'We have received your profile, please wait for admin to approve your profile' })
        }
        else {
            return res.status(401).json({ message: 'Please link email to your account' })
        }

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

    private async uploadPersonalImg(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'personalImg', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        await DriverModel.updateOne({id: req.body.id}, {avatar: req.cloudinaryResult.secure_url || req.cloudinaryResult.url})
        return res.status(200).json({ message: 'Upload avatar successfully' })
    }

    private async uploadDriverLicenseFrontsight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'driverLicenseFrontsight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload driver license frontsight successfully' })
    }

    private async uploadDriverLicenseBacksight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'driverLicenseBacksight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload driver license backsight successfully' })
    }

    private async uploadIdentityImgFrontsight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'identityImgFrontsight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload identity img frontsight successfully' })
    }

    private async uploadIdentityImgBacksight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'identityImgBacksight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload identity img backsight successfully' })
    }

    private async uploadVehicleImgFrontsight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'vehicleImgFrontsight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload vehicle img frontsight successfully' })
    }

    private async uploadVehicleImgBacksight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'vehicleImgBacksight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload vehicle img backsight successfully' })
    }

    private async uploadVehicleImgLeftsight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'vehicleImgLeftsight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload vehicle img leftsight successfully' })
    }

    private async uploadVehicleImgRightsight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'vehicleImgRightsight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload vehicle img rightsight successfully' })
    }

    private async uploadVehicleRegistrationFrontsight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'vehicleRegistrationFrontsight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload vehicle registration frontsight successfully' })
    }

    private async uploadVehicleRegistrationBacksight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'vehicleRegistrationBacksight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload vehicle registration backsight successfully' })
    }

    private async uploadVehicleInsuranceFrontsight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'vehicleInsuranceFrontsight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload vehicle insurance frontsight successfully' })
    }

    private async uploadVehicleInsuranceBacksight(req: Request, res: Response, next: NextFunction) {
        await adminClient.updateServiceApproval(req.body.id, 'vehicleInsuranceBacksight', req.cloudinaryResult.secure_url || req.cloudinaryResult.url)
        return res.status(200).json({ message: 'Upload vehicle insurance backsight successfully' })
    }


}

export default new DriverController()
