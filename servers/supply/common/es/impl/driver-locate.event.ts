import { JSONEventType } from '@eventstore/db-client'

export type DriverLocateEvent = JSONEventType<
    'driver-locate-event',
    Readonly<{
        driverId: string
        coordinate: {
            latitude: number
            longitude: number
            bearing: number
        }
    }>
>
