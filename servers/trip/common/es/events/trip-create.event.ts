import { JSONEventType } from '@eventstore/db-client'

export type TripCreateEvent = JSONEventType<
    'trip-create-event',
    Readonly<{
        tripId: string
        customerId: string
        status: string
        distance: string
        eta: string
        origin: {
            lat: number
            lng: number
            description: string
        }
        destination: {
            lat: number
            lng: number
            description: string
        }
        price: string
        serviceId: string
        createdAt: Date
    }>
>
