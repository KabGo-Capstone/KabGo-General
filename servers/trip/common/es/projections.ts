import { TripCancelEvent } from './events/trip-cancel.event'
import TripModel, { ITrip } from 'common/models/trip.model'
import { SubscriptionResolvedEvent } from '../../../event-store/subscriptions'
import { TripErrors } from './commanders'
import { isTripEvent } from './events'
import { TripCreateEvent } from './events/trip-create.event'
import mongoose from 'mongoose'
import { DriverLocateEvent } from './events/driver-locate.event'
import {
    retryIfNotFound,
    retryIfNotUpdated,
} from '../../../event-store/mongodb'
import { DriverAcceptEvent } from './events/driver-accept.event'
import { DriverComeEvent } from './events/driver-come.event'
import { TripStartEvent } from './events/trip-start.event'
import { TripFinishEvent } from './events/trip-finish.event'
import { DriverCancelEvent } from './events/driver-cancel.event'

export const projectToTrip = (
    resolvedEvent: SubscriptionResolvedEvent
): Promise<void> => {
    if (resolvedEvent.event === undefined || !isTripEvent(resolvedEvent.event))
        return Promise.resolve()

    const { event } = resolvedEvent
    const streamRevision = Number(event.revision)

    switch (event.type) {
        case 'trip-create-event': {
            return projectTripCreated(event, streamRevision)
        }

        case 'driver-locate-event':
        case 'driver-come-event':
        case 'trip-start-event':
        case 'trip-finish-event':
        case 'trip-cancel-event': {
            return projectToDriverUpdateStatus(event, streamRevision)
        }

        case 'driver-accept-event': {
            return projectToDriverAccept(event, streamRevision)
        }

        case 'driver-cancel-event': {
            return projectToDriverCancel(event, streamRevision)
        }

        default: {
            throw TripErrors.UNKNOWN_EVENT_TYPE
        }
    }
}

export const projectTripCreated = async (
    event: TripCreateEvent,
    streamRevision: number
): Promise<void> => {
    const newTrip = new TripModel({
        _id: event.data.tripId,
        customerId: event.data.customerId,
        status: event.data.status,
        distance: event.data.distance,
        eta: event.data.eta,
        origin: {
            lat: event.data.origin.lat,
            lng: event.data.origin.lng,
            description: event.data.origin.description,
        },
        destination: {
            lat: event.data.destination.lat,
            lng: event.data.destination.lng,
            description: event.data.destination.description,
        },
        revision: streamRevision,
        price: event.data.price,
        serviceId: event.data.serviceId,
        createdAt: event.data.createdAt,
    })

    await newTrip.save()
}

export const projectToDriverUpdateStatus = async (
    event:
        | DriverLocateEvent
        | DriverComeEvent
        | TripStartEvent
        | TripFinishEvent
        | TripCancelEvent,
    streamRevision: number
) => {
    const lastRevision = streamRevision - 1

    const { revision } = await retryIfNotFound<ITrip>(() =>
        TripModel.findOne(
            {
                _id: event.data.tripId,
                revision: { $gte: lastRevision },
            },
            {
                projection: { revision: 1 },
            }
        ).lean()
    )

    if (revision > lastRevision) {
        return
    }

    await retryIfNotUpdated(() =>
        TripModel.updateOne(
            {
                _id: event.data.tripId,
                revision: lastRevision,
            },
            {
                status: event.data.status,
                revision: streamRevision,
            },
            { upsert: false }
        )
    )
}

export const projectToDriverAccept = async (
    event: DriverAcceptEvent,
    streamRevision: number
): Promise<void> => {
    const lastRevision = streamRevision - 1

    const { revision } = await retryIfNotFound<ITrip>(() =>
        TripModel.findOne(
            {
                _id: event.data.tripId,
                revision: { $gte: lastRevision },
            },
            {
                projection: { revision: 1 },
            }
        ).lean()
    )

    if (revision > lastRevision) {
        return
    }

    await retryIfNotUpdated(() =>
        TripModel.updateOne(
            {
                _id: event.data.tripId,
                revision: lastRevision,
            },
            {
                $set: {
                    driverId: event.data.driverId,
                    status: event.data.status,
                    revision: streamRevision,
                },
            },
            { upsert: false }
        )
    )
}

export const projectToDriverCancel = async (
    event: DriverCancelEvent,
    streamRevision: number
): Promise<void> => {
    const lastRevision = streamRevision - 1

    const trip = await retryIfNotFound<any>(() =>
        TripModel.findOne({
            _id: event.data.tripId,
            revision: { $gte: lastRevision },
        })
    )

    if (trip.revision > lastRevision) {
        return
    }

    await retryIfNotUpdated(() => {
        delete trip.driverId
        trip.status = event.data.status
        trip.revision = streamRevision
        return trip.save()
    })
}
