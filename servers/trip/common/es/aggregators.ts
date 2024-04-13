import { StreamAggregator } from '../../../event-store/event-store'
import { TripState } from './entities/trip.entity'
import { TripEvent } from './events'

export const getTripState = StreamAggregator<TripState, TripEvent>(
    (currentState, event) => {
        if (event.type === 'trip-create-event') {
            if (currentState) throw new Error('trip has already been create')

            return {
                tripId: event.data.tripId,
                customerId: event.data.customerId,
                status: event.data.status,
                distance: event.data.distance,
                eta: event.data.eta,
                origin: event.data.origin,
                destination: event.data.destination,
                price: event.data.price,
                serviceId: event.data.serviceId,
                createdAt: new Date(event.data.createdAt),
            }
        }

        if (!currentState) throw new Error('trip has not been created yet')

        switch (event.type) {
            case 'driver-locate-event':
            case 'driver-come-event':
            case 'trip-start-event':
            case 'trip-finish-event':
            case 'trip-cancel-event':
                return {
                    ...currentState,
                    status: event.data.status,
                }

            case 'driver-accept-event':
                return {
                    ...currentState,
                    driverId: event.data.driverId,
                    status: event.data.status,
                }

            case 'driver-cancel-event':
                return {
                    ...currentState,
                    driverId: undefined,
                    status: event.data.status,
                }

            default: {
                throw new Error('invalid event type')
            }
        }
    }
)
