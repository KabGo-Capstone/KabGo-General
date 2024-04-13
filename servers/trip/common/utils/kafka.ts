import { create, update } from './../../../event-store/command.handler'
import { Kafka } from 'kafkajs'
import Logger from '../utils/logger'
import chalk from 'chalk'
import {
    createTrip,
    driverAcceptForTrip,
    driverComeForTrip,
    driverLocatingForTrip,
    finishTrip,
    toTripStreamName,
    TripStatus,
} from 'common/es/commanders'
import { getEventStore } from '../../../event-store/event-store'
import mongoose from 'mongoose'

const brokers = ['0.0.0.0:9092']
const kafka = new Kafka({
    clientId: 'trip-service',
    brokers,
})

const producer = kafka.producer()
const consumer = kafka.consumer({ groupId: 'trip-service' })

const topicsToProduce = ['demand-booking', 'trip-status'] as const
const topicsToSubscribe = ['trip-order'] as const
const topicToSubscribeHandlers: Record<
    (typeof topicsToSubscribe)[number],
    // eslint-disable-next-line @typescript-eslint/ban-types
    Function
> = {
    'trip-order': tripOrderTopicHandler,
}
// eslint-disable-next-line @typescript-eslint/ban-types
const statusHandler: Record<string, any> = {
    [TripStatus.Accept]: driverAcceptForTrip,
    [TripStatus.Come]: driverComeForTrip,
    [TripStatus.Finish]: finishTrip,
}

async function tripOrderTopicHandler(data: any) {
    console.log(
        'Got a new message from trip-order topic: ',
        JSON.stringify(data)
    )

    try {
        let eTag: bigint
    } catch (error) {
        console.log(error)
    }
    // const io = socketIO.getIO()
    // io.customer_sockets[data.customer].socket?.emit('near-driver', data.drivers)
}

export async function connectProducer() {
    await producer.connect()
}

export async function connectConsumer() {
    await consumer.connect()

    for await (const element of topicsToSubscribe) {
        consumer.subscribe({
            topic: element,
            fromBeginning: true,
        })
    }

    Logger.info(chalk.green('Consumer connected to kafka successfully.'))

    await consumer.run({
        eachMessage: async ({ topic, partition, message }) => {
            if (!message || !message.value) {
                return
            }

            const data = JSON.parse(message.value.toString())

            const handler =
                topicToSubscribeHandlers[
                    topic as keyof typeof topicToSubscribeHandlers
                ]

            if (handler) {
                handler(data)
            }
        },
    })
}

export async function sendMessage(
    topic: (typeof topicsToProduce)[number],
    message: any
) {
    return producer.send({
        topic,
        messages: [{ value: message }],
    })
}

export async function disconnectProducerFromKafka() {
    await producer.disconnect()
    console.log('Disconnected from producer...')
}
export async function disconnectConsumerFromKafKa() {
    await consumer.disconnect()
    console.log('Disconnected from consumer...')
}
