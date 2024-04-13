import {
  EventType,
  RecordedEvent,
  StreamingRead,
  ResolvedEvent,
  EventStoreDBClient,
} from "@eventstore/db-client";

type ApplyEvent<Entity, E extends EventType> = (
  currentState: Entity | undefined,
  event: RecordedEvent<E>
) => Entity;

const enum StreamAggregatorErrors {
  STREAM_WAS_NOT_FOUND,
}

export const StreamAggregator =
  <Entity, E extends EventType>(when: ApplyEvent<Entity, E>) =>
  async (eventStream: StreamingRead<ResolvedEvent<E>>): Promise<Entity> => {
    let currentState: Entity | undefined = undefined;

    for await (const { event } of eventStream) {
      if (!event) continue;

      currentState = when(currentState, event);
    }

    if (!currentState) throw StreamAggregatorErrors.STREAM_WAS_NOT_FOUND;
    return currentState;
  };

let eventStore: EventStoreDBClient;

export const getEventStore = (connectionString?: string) => {
  if (!eventStore) {
    eventStore = EventStoreDBClient.connectionString(
      connectionString ?? "esdb://192.168.1.4:2113?tls=false"
    );
  }

  return eventStore;
};
