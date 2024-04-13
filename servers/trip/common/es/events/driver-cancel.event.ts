import { JSONEventType } from '@eventstore/db-client'

export type DriverCancelEvent = JSONEventType<
    'driver-cancel-event',
    Readonly<{
        tripId: string
        status: string
    }>
>
