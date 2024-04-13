import { TripCreateEvent } from './trip-create.event'
import { DriverLocateEvent } from './driver-locate.event'
import { DriverComeEvent } from './driver-come.event'
import { TripStartEvent } from './trip-start.event'
import { TripFinishEvent } from './trip-finish.event'
import { TripCancelEvent } from './trip-cancel.event'
import { DriverAcceptEvent } from './driver-accept.event'
import { DriverCancelEvent } from './driver-cancel.event'

export type TripEvent =
    | TripCreateEvent
    | DriverLocateEvent
    | DriverAcceptEvent
    | DriverCancelEvent
    | DriverComeEvent
    | TripStartEvent
    | TripFinishEvent
    | TripCancelEvent

export const isTripEvent = (event: unknown): event is TripEvent => {
    const eventType = (event as TripEvent).type

    return (
        event != null &&
        [
            'trip-create-event',
            'driver-locate-event',
            'driver-come-event',
            'trip-start-event',
            'trip-finish-event',
            'trip-cancel-event',
            'driver-accept-event',
            'driver-cancel-event',
        ].includes(eventType)
    )
}
