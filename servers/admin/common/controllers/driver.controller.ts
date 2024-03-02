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

const serviceApprovalData = DummyData.serviceApprovals
const vehicleData = DummyData.vehicles
const serviceData = DummyData.services
const supplyClient = SupplyStub.client()

class DriverController implements IController {
    readonly path: string = '/driver/approval'
    readonly router: Router = Router()

    constructor() {
        this.router.get('/', catchAsync(this.getServiceApprovals.bind(this)))
        this.router.post('/approve/:id', catchAsync(this.approveDriver))
        this.router.patch('/approve/:id', catchAsync(this.disapproveDriver))
        this.router.delete(
            '/:id',
            catchAsync(this.deleteDriverApproval.bind(this))
        )
        // this.router.post('/create', catchAsync(this.createDriver))
    }

    private async getDetailsServiceApproval() {
        const serviceApprovals = []

        for await (const service of serviceApprovalData) {
            const supply = await supplyClient.findById(service.supplyID)

            serviceApprovals.push({
                ...service,
                vehicle: vehicleData.find(
                    (data) => data.id === service.vehicle_id
                ),
                service: serviceData.find(
                    (data) => data.id === service.service_id
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
        const approvalIndex = serviceApprovalData.findIndex(
            (el) => el.id === req.params.id
        )
        serviceApprovalData[approvalIndex].status = 'approved'

        const supplyVerivied = await supplyClient.verify(
            serviceApprovalData[approvalIndex].supplyID
        )

        return res.status(200).json({
            data: {
                ...serviceApprovalData[approvalIndex],
                vehicle: vehicleData.find(
                    (data) =>
                        data.id ===
                        serviceApprovalData[approvalIndex].vehicle_id
                ),
                service: serviceData.find(
                    (data) =>
                        data.id ===
                        serviceApprovalData[approvalIndex].service_id
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
        const approvalIndex = serviceApprovalData.findIndex(
            (el) => el.id === req.params.id
        )
        serviceApprovalData[approvalIndex].status = 'pending'

        const supplyVerivied = await supplyClient.verify(
            serviceApprovalData[approvalIndex].supply_id
        )

        return res.status(200).json({
            data: {
                ...serviceApprovalData[approvalIndex],
                vehicle: vehicleData.find(
                    (data) =>
                        data.id ===
                        serviceApprovalData[approvalIndex].vehicle_id
                ),
                service: serviceData.find(
                    (data) =>
                        data.id ===
                        serviceApprovalData[approvalIndex].service_id
                ),
                supply: supplyVerivied,
            },
        })
    }

    private async deleteDriverApproval(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const index = serviceApprovalData.findIndex(
            (data) => data.id === req.params.id
        )

        serviceApprovalData.splice(index, 1)

        const serviceApprovals = await this.getDetailsServiceApproval()

        return res.status(200).json({ data: serviceApprovals })
    }

    private async createDriver(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const supplyData = (await supplyClient.find()).drivers

        const createData = {
            id: String(supplyData.length + 1),
            ...req.body,
        }

        supplyData.push(createData)
        return res.status(200).json({ data: supplyData })
    }
}

export default new DriverController()
