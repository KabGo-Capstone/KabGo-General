import { JSONEventType } from '@eventstore/db-client'

export type DriverAcceptEvent = JSONEventType<
    'driver-accept-event',
    Readonly<{
        tripId: string
        driverId: string
        status: string
    }>
>
