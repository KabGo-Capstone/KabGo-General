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
import SupplyStub from '../services/supply.service'

import ServiceApprovalModel from '../models/serviceApproval.model'
import ServiceModel from '../models/service.model'
import VehicleModel from '../models/vehicle.model'

import { getServiceApprovalData } from '../dummy_data/service_approval_data'
import { getServiceData } from '../dummy_data/service_data'
import { getVehicleData } from '../dummy_data/vehicle_data'

// const serviceApprovalData = DummyData.serviceApprovals
// const vehicleData = DummyData.vehicles
// const serviceData = DummyData.services
const supplyClient = SupplyStub.client()

class DriverController implements IController {
    readonly path: string = '/driver/approval'
    readonly router: Router = Router()

    constructor() {
        this.router.get('/', catchAsync(this.getServiceApprovals.bind(this)))
        this.router.post('/approve/:id', catchAsync(this.approveDriver))
        this.router.patch('/disapprove/:id', catchAsync(this.disapproveDriver))
        this.router.delete(
            '/:id',
            catchAsync(this.deleteDriverApproval.bind(this))
        )
        this.router.get('/create', catchAsync(this.createDB))
        this.router.get('/delete', catchAsync(this.deleteDB))
    }

    private async getDetailsServiceApproval() {

        const serviceApprovalData = await getServiceApprovalData();
        const vehicleData = await getVehicleData();
        const serviceData = await getServiceData();
        const serviceApprovals = []

        for await (const service of serviceApprovalData) {
            const supply = await supplyClient.findById(service.supplyID)

            serviceApprovals.push({
                ...service,
                vehicle: vehicleData.find(
                    (data) => data.id === service.vehicleID
                ),
                service: serviceData.find(
                    (data) => data.id === service.serviceID
                ),
                supply: supply,
            })
        }

        return serviceApprovals
    }

    private async getServiceApprovals(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const serviceApprovals = await this.getDetailsServiceApproval()

        return res.status(200).json({ data: serviceApprovals })
    }

    private async approveDriver(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const serviceApprovalData = await getServiceApprovalData();
        const vehicleData = await getVehicleData();
        const serviceData = await getServiceData();

        const approvalIndex = serviceApprovalData.findIndex(
            (el) => el.id === req.params.id
        )

        await ServiceApprovalModel.updateOne({ id: req.params.id }, { status: 'approved' });
        // serviceApprovalData[approvalIndex].status = 'approved'

        const supplyVerivied = await supplyClient.verify(
            serviceApprovalData[approvalIndex].supplyID
        )

        return res.status(200).json({
            data: {
                ...serviceApprovalData[approvalIndex],
                vehicle: vehicleData.find(
                    (data) =>
                        data.id === serviceApprovalData[approvalIndex].vehicleID
                ),
                service: serviceData.find(
                    (data) =>
                        data.id === serviceApprovalData[approvalIndex].serviceID
                ),
                supply: supplyVerivied,
            },
        })
    }

    private async disapproveDriver(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const serviceApprovalData = await getServiceApprovalData();
        const vehicleData = await getVehicleData();
        const serviceData = await getServiceData();

        const approvalIndex = serviceApprovalData.findIndex(
            (el) => el.id === req.params.id
        )
        await ServiceApprovalModel.updateOne({ id: req.params.id }, { status: 'pending' });
        // serviceApprovalData[approvalIndex].status = 'pending'

        const supplyUnVerivied = await supplyClient.unverify(
            serviceApprovalData[approvalIndex].supplyID
        )

        return res.status(200).json({
            data: {
                ...serviceApprovalData[approvalIndex],
                vehicle: vehicleData.find(
                    (data) =>
                        data.id === serviceApprovalData[approvalIndex].vehicleID
                ),
                service: serviceData.find(
                    (data) =>
                        data.id === serviceApprovalData[approvalIndex].serviceID
                ),
                supply: supplyUnVerivied,
            },
        })
    }

    private async deleteDriverApproval(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const serviceApprovalData = await getServiceApprovalData();
        const index = serviceApprovalData.findIndex(
            (data) => data.id === req.params.id
        )

        await ServiceApprovalModel.deleteOne({ id: req.params.id });

        // serviceApprovalData.splice(index, 1)

        const serviceApprovals = await this.getDetailsServiceApproval()

        return res.status(200).json({ data: serviceApprovals })
    }

    private async createDB(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        for await (const serviceApproval of DummyData.serviceApprovals) {
            await ServiceApprovalModel.create(serviceApproval);
        }

        for await (const service of DummyData.services) {
            await ServiceModel.create(service);
        }

        for await (const vehicle of DummyData.vehicles) {
            await VehicleModel.create(vehicle);
        }

        return res.status(200).json({ data: 'Create data successfully' })
    }

    private async deleteDB(
        req: Request,
        res: Response,
        next: NextFunction
    ) {

        await ServiceApprovalModel.deleteMany();

        await ServiceModel.deleteMany();

        await VehicleModel.deleteMany();

        return res.status(200).json({ data: 'Delete data successfully' })
    }
}

export default new DriverController()
