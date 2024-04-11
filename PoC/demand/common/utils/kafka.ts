import { Kafka } from "kafkajs";
import Logger from '../utils/logger'
import chalk from "chalk";
import socketIO from "common/socket";

const brokers = ["0.0.0.0:9092"];
const kafka = new Kafka({
  clientId: "demand-service",
  brokers,
});

const producer = kafka.producer();
const consumer = kafka.consumer({ groupId: "demand-service" });

const topicsToProduce = ["demand-booking"] as const;
const topicsToSubscribe = ["supply-suggesting", "trip-tracking"] as const;
// eslint-disable-next-line @typescript-eslint/ban-types
const topicToSubscribeHandlers: Record<typeof topicsToSubscribe[number], Function> = {
  "supply-suggesting": supplySuggestingTopicHandler,
  "trip-tracking": tripTrackingTopicHandler,
};

function supplySuggestingTopicHandler(data: any) {
  console.log("Got a new message from supply-suggesting topic: ", JSON.stringify(data, null, 2));
  const io = socketIO.getIO();
  io.customer_sockets[data.customer].socket?.emit('near-driver', data.drivers);

}
function tripTrackingTopicHandler(data: any) {
  console.log("Got a new message from trip-tracking topic: ", JSON.stringify(data, null, 2));
}

export async function connectProducer() {
  await producer.connect();
}

export async function connectConsumer() {
  await consumer.connect();

  for (let i = 0; i < topicsToSubscribe.length; i++) {
    await consumer.subscribe({
      topic: topicsToSubscribe[i],
      fromBeginning: true,
    });
  }

  Logger.info(chalk.green("Consumer connected to kafka successfully."));

  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      if (!message || !message.value) {
        return;
      }

      const data = JSON.parse(message.value.toString());

      const handler = topicToSubscribeHandlers[topic as keyof typeof topicToSubscribeHandlers];

      if (handler) {
        handler(data);
      }
    },
  });
}

export async function sendMessage(topic: typeof topicsToProduce[number], message: any) {
  return producer.send({
    topic,
    messages: [{ value: message }],
  });
}

export async function disconnectProducerFromKafka() {
  await producer.disconnect();
  console.log("Disconnected from producer...");
}
export async function disconnectConsumerFromKafKa() {
  await consumer.disconnect();
  console.log("Disconnected from consumer...");
}
