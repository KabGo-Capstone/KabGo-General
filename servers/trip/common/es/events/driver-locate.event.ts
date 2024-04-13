import { JSONEventType } from '@eventstore/db-client'

export type DriverLocateEvent = JSONEventType<
    'driver-locate-event',
    Readonly<{
        tripId: string
        status: string
    }>
>
