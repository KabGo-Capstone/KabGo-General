import { DriverActiveEvent } from './driver-active.event'
import { DriverCancelEvent } from './driver-cancel.event'
import { DriverInActiveEvent } from './driver-inactive.event'
import { DriverLocateEvent } from './driver-locate.event'
import { DriverReceivedEvent } from './driver-received.event'

export type DriverEvent =
    | DriverActiveEvent
    | DriverInActiveEvent
    | DriverLocateEvent
    | DriverReceivedEvent
    | DriverCancelEvent
