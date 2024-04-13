import { JSONEventType } from '@eventstore/db-client'

export type TripStartEvent = JSONEventType<
    'trip-start-event',
    Readonly<{
        tripId: string
        status: string
    }>
>
