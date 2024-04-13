import { JSONEventType } from '@eventstore/db-client'

export type DriverReceivedEvent = JSONEventType<
    'driver-received-event',
    Readonly<{
        driverId: string
        customerId: string
        tripId: string
    }>
>
