import { JSONEventType } from '@eventstore/db-client'

export type DriverActiveEvent = JSONEventType<
    'driver-active-event',
    Readonly<{
        driverId: string
        driverActive: boolean
        activeAt: Date
    }>
>
