import { Kafka } from 'kafkajs'
import Logger from '../utils/logger'
import chalk from 'chalk'
import socketIO from 'common/socket'

const brokers = ['0.0.0.0:9092']
const kafka = new Kafka({
    clientId: 'supply-service',
    brokers,
})

const producer = kafka.producer()
const consumer = kafka.consumer({ groupId: 'supply-service' })

const topicsToProduce = [
    'supply-info',
    'accept-booking',
    'trip-tracking',
    'driver-come',
    'driver-ongoing',
    'trip-finish',
] as const
const topicsToSubscribe = ['supply-suggesting'] as const
const topicToSubscribeHandlers: Record<
    (typeof topicsToSubscribe)[number],
    // eslint-disable-next-line @typescript-eslint/ban-types
    Function
> = {
    'supply-suggesting': supplySuggestingTopicHandler,
    // 'trip-tracking': tripTrackingTopicHandler,
}

function supplySuggestingTopicHandler(data: any) {
    // console.log(
    //     'Got a new message from supply-suggesting topic: ',
    //     data
    // )

    data.drivers.forEach((el: any) => {
        const io = socketIO.getIO()

        if (
            io.driver_sockets &&
            el.driverId in io.driver_sockets &&
            io.driver_sockets[el.driverId] &&
            io.driver_sockets[el.driverId].status !== 'BUSY'
        ) {
            io.driver_sockets[el.driverId].status = 'BUSY'
            io.driver_sockets[el.driverId].socket.emit('demand-suggesting', {
                tripInfo: data.tripInfo,
            })
            console.log('EMIT')
        }
    })
}

function tripTrackingTopicHandler(data: string) {
    // console.log(
    //     'Got a new message from trip-tracking topic: ',
    //     JSON.stringify(data, null, 2)
    // )
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
