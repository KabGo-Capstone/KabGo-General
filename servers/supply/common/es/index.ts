import { EventStoreDBClient } from '@eventstore/db-client'

let eventStore: EventStoreDBClient

export const getEventStore = (connectionString?: string) => {
    if (!eventStore) {
        eventStore = EventStoreDBClient.connectionString(
            connectionString ?? 'esdb://localhost:2113?tls=false'
        )
    }

    return eventStore
}
