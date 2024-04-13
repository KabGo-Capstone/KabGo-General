import { JSONEventType } from '@eventstore/db-client'

export type DriverInActiveEvent = JSONEventType<
    'driver-in-active-event',
    Readonly<{
        driverId: string
        driverActive: boolean
        activeAt: Date | null
    }>
>
