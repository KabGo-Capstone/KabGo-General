import { Kafka } from "kafkajs";
import Logger from '../utils/logger'
import chalk from "chalk";
import socketIO from "common/socket";

// initialize the driver list, and the demand booking list
export const driverList: Record<string, any> = {};
export const demandBookingList: Record<string, any> = {};


const brokers = ["0.0.0.0:9092"];
const kafka = new Kafka({
  clientId: "dispatcher-service",
  brokers,
});

const producer = kafka.producer();
const consumer = kafka.consumer({ groupId: "dispatcher-service" });


const topicsToProduce = ["supply-suggesting", "trip-tracking"] as const;
const topicsToSubscribe = ["demand-booking", "supply-info"] as const;
// eslint-disable-next-line @typescript-eslint/ban-types
const topicToSubscribeHandlers: Record<typeof topicsToSubscribe[number], Function> = {
  "demand-booking": demandBookingTopicHandler,
  "supply-info": supplyInfoTopicHandler,
};

function demandBookingTopicHandler(data: any) {
  console.log("Got a new message from demand-booking topic: ", JSON.stringify(data, null, 2));
  demandBookingList[data.id] = data; // mặc định là trạng thái free, và chỉ update lại khi khách hàng đặt xe
  // demandBookingList = demandBookingList.filter((booking) => booking.id !== data.id);
  // demandBookingList.push(data); 
}
function supplyInfoTopicHandler(data: any) {
  console.log("Got a new message from supply-info topic: ", JSON.stringify(data, null, 2));
  // driverList = driverList.filter((driver) => driver.id !== data.id);
  // driverList.push(data); 
  driverList[data.id] = data; // mặc định là trạng thái free, và chỉ update lại khi tài xế hoàn thành cuốc xe, trong lúc thực hiện cuốc xe thì tài xế sẽ không cập nhật lại tọa độ 5s 1 lần
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