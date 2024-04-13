import { Kafka } from 'kafkajs'
import Logger from '../utils/logger'
import chalk from 'chalk'
import { latLngToCell } from 'h3-js'
import H3Geometry from './h3.geometry'

export const driverList: Record<string, any> = {}
export const demandBookingList: Record<string, any> = {}

const brokers = ['0.0.0.0:9092']
const kafka = new Kafka({
    clientId: 'dispatcher-service',
    brokers,
})

const producer = kafka.producer()
const consumer = kafka.consumer({ groupId: 'dispatcher-service' })

const topicsToProduce = ['supply-suggesting', 'trip-tracking'] as const
const topicsToSubscribe = [
    'demand-booking',
    'supply-info',
    'trip-status',
    'accept-booking',
] as const
const topicToSubscribeHandlers: Record<
    (typeof topicsToSubscribe)[number],
    // eslint-disable-next-line @typescript-eslint/ban-types
    Function
> = {
    'demand-booking': demandBookingTopicHandler,
    'supply-info': supplyInfoTopicHandler,
    'trip-status': updateTripStatusHandler,
    'accept-booking': updateAcceptBookingTopicHandler,
}

function demandBookingTopicHandler(data: any) {
    console.log('Got a new message from demand-booking topic: ', data)
    demandBookingList[data.customerId] = data
}

function supplyInfoTopicHandler(data: any) {
    // console.log(
    //     'Got a new message from supply-info topic: ',
    //     data
    // )
    const driver = data
    if (driver.status === 'OFF') {
        delete driverList[driver.driverId]
        return
    }
    driverList[driver.driverId] = driver
}

function updateTripStatusHandler(data: any) {
    demandBookingList[data.customerId] = data
}

function updateAcceptBookingTopicHandler(data: any) {
    demandBookingList[data.tripInfo.customerId].status = 'ACCEPTED'
    demandBookingList[data.tripInfo.customerId].driver = data.driverInfo
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
