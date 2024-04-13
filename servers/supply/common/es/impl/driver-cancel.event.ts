import { JSONEventType } from '@eventstore/db-client'

export type DriverCancelEvent = JSONEventType<
    'driver-cancel-event',
    Readonly<{
        driverId: string
        customerId: string
        tripId: string
    }>
>
