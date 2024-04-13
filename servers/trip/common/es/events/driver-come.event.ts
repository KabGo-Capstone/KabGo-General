import { JSONEventType } from '@eventstore/db-client'

export type DriverComeEvent = JSONEventType<
    'driver-come-event',
    Readonly<{
        tripId: string
        status: string
    }>
>
