import { DriverAcceptCommand } from './commands/driver-accept.command'
import { ResolvedEvent, StreamingRead } from '@eventstore/db-client'
import { TripState } from './entities/trip.entity'
import { TripCreateEvent } from './events/trip-create.event'
import { TripEvent } from './events'
import { DriverLocateEvent } from './events/driver-locate.event'
import { getTripState } from './aggregators'
import { TripCommand } from './commands'
import { DriverComeEvent } from './events/driver-come.event'
import { DriverAcceptEvent } from './events/driver-accept.event'
import { TripStartEvent } from './events/trip-start.event'
import { TripFinishEvent } from './events/trip-finish.event'

export const enum TripStatus {
    Created = 'CREATED',
    Locating = 'LOCATING',
    Accept = 'ACCEPTED',
    Come = 'COME',
    Start = 'PROCESSING',
    Finish = 'FINISHED',
    Cancel = 'CANCELED',
}

export const enum TripErrors {
    CREATED_EXISTING_TRIP = 'CREATED_EXISTING_TRIP',
    TRIP_IS_ALREADY_CANCELED = 'TRIP_IS_ALREADY_CANCELED',
    TRIP_IS_NOT_LOCATED = 'TRIP_IS_NOT_LOCATED',
    DRIVER_IS_NOT_FOUND = 'DRIVER_IS_NOT_FOUND',
    DRIVER_IS_NOT_COME = 'DRIVER_IS_NOT_COME',
    TRIP_IS_NOT_STARTED = 'TRIP_IS_NOT_STARTED',
    TRIP_NOT_FOUND = 'TRIP_NOT_FOUND',
    DRIVER_NOT_FOUND = 'DRIVER_NOT_FOUND',
    UNKNOWN_EVENT_TYPE = 'UNKNOWN_EVENT_TYPE',
}

export const toShoppingCartStreamName = (shoppingCartId: string) =>
    `shopping_cart-${shoppingCartId}`

export const assertTripIsNotCanceled = (trip: TripState) => {
    if (trip.status === TripStatus.Cancel) {
        throw TripErrors.TRIP_IS_ALREADY_CANCELED
    }
}

export const assertTripIsLocated = (trip: TripState) => {
    if (trip.status !== TripStatus.Locating) {
        throw TripErrors.TRIP_IS_NOT_LOCATED
    }
}

export const assertTripIsAccepted = (trip: TripState) => {
    if (!trip.driverId) {
        throw TripErrors.DRIVER_IS_NOT_FOUND
    }
}

export const assertTripIsComming = (trip: TripState) => {
    if (trip.status !== TripStatus.Come) {
        throw TripErrors.DRIVER_IS_NOT_COME
    }
}

export const assertTripIsStart = (trip: TripState) => {
    if (trip.status !== TripStatus.Start) {
        throw TripErrors.TRIP_IS_NOT_STARTED
    }
}

export const toTripStreamName = (tripId: string) => `trip-${tripId}`

export const createTrip = ({
    tripId,
    customerId,
    status,
    distance,
    eta,
    origin,
    destination,
    price,
    serviceId,
}: TripState): TripCreateEvent => {
    return {
        type: 'trip-create-event',
        data: {
            tripId,
            customerId,
            status,
            distance,
            eta,
            origin,
            destination,
            price,
            serviceId,
            createdAt: new Date(),
        },
    }
}

export const driverLocatingForTrip = async (
    events: StreamingRead<ResolvedEvent<TripEvent>>,
    { tripId, status }: TripCommand
): Promise<DriverLocateEvent> => {
    const trip = await getTripState(events)

    assertTripIsNotCanceled(trip)

    return {
        type: 'driver-locate-event',
        data: {
            tripId,
            status,
        },
    }
}

export const driverAcceptForTrip = async (
    events: StreamingRead<ResolvedEvent<TripEvent>>,
    { tripId, driverId, status }: DriverAcceptCommand
): Promise<DriverAcceptEvent> => {
    const trip = await getTripState(events)

    assertTripIsNotCanceled(trip)
    assertTripIsLocated(trip)

    return {
        type: 'driver-accept-event',
        data: {
            tripId,
            driverId,
            status,
        },
    }
}

export const driverComeForTrip = async (
    events: StreamingRead<ResolvedEvent<TripEvent>>,
    { tripId, status }: TripCommand
): Promise<DriverComeEvent> => {
    const trip = await getTripState(events)

    assertTripIsNotCanceled(trip)
    assertTripIsAccepted(trip)

    return {
        type: 'driver-come-event',
        data: {
            tripId,
            status,
        },
    }
}

export const startTrip = async (
    events: StreamingRead<ResolvedEvent<TripEvent>>,
    { tripId, status }: TripCommand
): Promise<TripStartEvent> => {
    const trip = await getTripState(events)

    assertTripIsNotCanceled(trip)
    assertTripIsAccepted(trip)
    assertTripIsComming(trip)

    return {
        type: 'trip-start-event',
        data: {
            tripId,
            status,
        },
    }
}

export const finishTrip = async (
    events: StreamingRead<ResolvedEvent<TripEvent>>,
    { tripId, status }: TripCommand
): Promise<TripFinishEvent> => {
    const trip = await getTripState(events)

    assertTripIsNotCanceled(trip)
    assertTripIsStart(trip)

    return {
        type: 'trip-finish-event',
        data: {
            tripId,
            status,
        },
    }
}
