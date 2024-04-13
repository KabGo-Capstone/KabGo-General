import { NextFunction, Request, Response, Router } from 'express'
import IController from '../interfaces/controller'
import catchAsync from '../utils/catch.error'
import TripModel from 'common/models/trip.model'
import {
    createTrip,
    driverAcceptForTrip,
    driverComeForTrip,
    driverLocatingForTrip,
    finishTrip,
    startTrip,
    toTripStreamName,
    TripStatus,
} from 'common/es/commanders'
import mongoose from 'mongoose'
import { getEventStore } from '../../../event-store/event-store'
import { create, update } from '../../../event-store/command.handler'

class TripController implements IController {
    readonly path: string = '/trips'
    readonly router: Router = Router()

    constructor() {
        this.router.get('/trip-status', catchAsync(this.getLocating))
        this.router.get('/trip-real-status', catchAsync(this.getTripStatus))
        this.router.post('/create-trip', catchAsync(this.bookTrip))
        this.router.post('/locate-driver', catchAsync(this.locateDriver))
        this.router.post('/accept-driver', catchAsync(this.acceptTrip))
        this.router.post('/driver-come', catchAsync(this.driverCome))
        this.router.post('/driver-ongoing', catchAsync(this.driverOnGoing))
        this.router.post('/trip-finish', catchAsync(this.tripFinish))
    }

    private async getTripStatus(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const queryById = req.query.customer
            ? {
                  customerId: req.query.customer,
              }
            : {
                  driverId: req.query.driver,
              }

        const locatingTrip = await TripModel.findOne({
            ...queryById,
        })

        res.json({
            message: 'success',
            data: locatingTrip ?? null,
        })
    }

    private async getLocating(req: Request, res: Response, next: NextFunction) {
        const queryById = req.query.customer
            ? {
                  customerId: req.query.customer,
              }
            : {
                  driverId: req.query.driver,
              }
        console.log(req.query.customer)
        const locatingTrip = await TripModel.findOne({
            status: {
                $nin: [TripStatus.Finish, TripStatus.Cancel],
            },
            ...queryById,
        })

        res.json({
            message: 'success',
            data: locatingTrip ?? null,
        })
    }

    private async bookTrip(req: Request, res: Response, next: NextFunction) {
        const tripId = new mongoose.Types.ObjectId()
        const streamName = toTripStreamName(tripId.toString())

        const result = await create(getEventStore(), createTrip)(streamName, {
            tripId,
            ...req.body.tripInfo,
        })

        const etag = result.nextExpectedRevision

        res.json({
            message: 'success',
            data: {
                tripId,
                ...req.body.tripInfo,
                Etag: etag.toString(),
            },
        })
    }

    private async locateDriver(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const tripInfo = req.body.tripInfo
        const tripId = tripInfo.tripId
        const streamName = toTripStreamName(tripId.toString())

        const result = await update(getEventStore(), driverLocatingForTrip)(
            streamName,
            req.body.tripInfo,
            tripInfo.Etag ?? tripInfo.revision + 1
        )

        const etag = result.nextExpectedRevision

        res.json({
            message: 'success',
            data: {
                ...req.body.tripInfo,
                Etag: etag.toString(),
            },
        })
    }

    private async acceptTrip(req: Request, res: Response, next: NextFunction) {
        const tripInfo = req.body.tripInfo
        const tripId = tripInfo.tripId

        const streamName = toTripStreamName(tripId.toString())

        const result = await update(getEventStore(), driverAcceptForTrip)(
            streamName,
            {
                tripId,
                driverId: tripInfo.driverId,
                status: tripInfo.status,
            },
            tripInfo.Etag ?? tripInfo.revision + 1
        )

        const etag = result.nextExpectedRevision

        res.json({
            message: 'success',
            data: {
                ...req.body.tripInfo,
                Etag: etag.toString(),
            },
        })
    }

    private async driverCome(req: Request, res: Response, next: NextFunction) {
        const tripInfo = req.body.tripInfo
        const tripId = tripInfo.tripId

        const streamName = toTripStreamName(tripId.toString())

        console.log(tripInfo)
        console.log(tripId)
        console.log(tripInfo.status)

        try {
            const result = await update(getEventStore(), driverComeForTrip)(
                streamName,
                {
                    tripId,
                    status: tripInfo.status,
                },
                tripInfo.Etag ?? tripInfo.revision + 1
            )
            const etag = result.nextExpectedRevision
            res.json({
                message: 'success',
                data: {
                    ...req.body.tripInfo,
                    Etag: etag.toString(),
                },
            })
        } catch (err) {
            console.log(err)
        }
    }

    private async driverOnGoing(
        req: Request,
        res: Response,
        next: NextFunction
    ) {
        const tripInfo = req.body.tripInfo
        const tripId = tripInfo.tripId

        const streamName = toTripStreamName(tripId.toString())

        const result = await update(getEventStore(), startTrip)(
            streamName,
            {
                tripId,
                status: tripInfo.status,
            },
            tripInfo.Etag ?? tripInfo.revision + 1
        )

        const etag = result.nextExpectedRevision

        res.json({
            message: 'success',
            data: {
                ...req.body.tripInfo,
                Etag: etag.toString(),
            },
        })
    }

    private async tripFinish(req: Request, res: Response, next: NextFunction) {
        const tripInfo = req.body.tripInfo
        const tripId = tripInfo.tripId

        const streamName = toTripStreamName(tripId.toString())

        const result = await update(getEventStore(), finishTrip)(
            streamName,
            {
                tripId,
                status: tripInfo.status,
            },
            tripInfo.Etag ?? tripInfo.revision + 1
        )

        const etag = result.nextExpectedRevision

        res.json({
            message: 'success',
            data: {
                ...req.body.tripInfo,
                Etag: etag.toString(),
            },
        })
    }
}

export default new TripController()
