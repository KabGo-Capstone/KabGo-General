import { StreamAggregator } from '../../../../event-store/event-store.cqrs'
import { DriverState } from '../entities/driver.entity'
import { DriverEvent } from '../impl'

const getDriverState = StreamAggregator<DriverState, DriverEvent>(
    (currentState, event) => {
        if (event.type === 'driver-active-event') {
            if (currentState) throw new Error('driver has already been active')

            return {
                driverId: event.data.driverId,
                driverActive: event.data.driverActive,
                activeAt: new Date(event.data.activeAt),
            }
        }

        if (!currentState) throw new Error('driver has not been active')

        switch (event.type) {
            case 'driver-locate-event':
                return {
                    ...currentState,
                    coordination: {
                        ...event.data.coordinate,
                    },
                }

            case 'driver-received-event':
                return {
                    ...currentState,
                    customerId: event.data.customerId,
                    tripId: event.data.tripId,
                }

            case 'driver-in-active-event':
                return {
                    ...currentState,
                    driverActive: event.data.driverActive,
                }

            case 'driver-cancel-event':
                return {
                    ...currentState,
                    customerId: undefined,
                    tripId: undefined,
                }

            default: {
                throw new Error('invalid event type')
            }
        }
    }
)
