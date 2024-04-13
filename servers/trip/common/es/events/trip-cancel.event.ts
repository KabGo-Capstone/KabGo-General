import { JSONEventType } from '@eventstore/db-client'

export type TripCancelEvent = JSONEventType<
    'trip-cancel-event',
    Readonly<{
        tripId: string
        status: string
    }>
>
