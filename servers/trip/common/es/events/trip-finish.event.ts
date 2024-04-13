import { JSONEventType } from '@eventstore/db-client'

export type TripFinishEvent = JSONEventType<
    'trip-finish-event',
    Readonly<{
        tripId: string
        status: string
    }>
>
