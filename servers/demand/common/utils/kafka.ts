import { Kafka } from 'kafkajs'
import Logger from '../utils/logger'
import chalk from 'chalk'
import socketIO from 'common/socket'

const brokers = ['0.0.0.0:9092']
const kafka = new Kafka({
    clientId: 'demand-service',
    brokers,
})

const producer = kafka.producer()
const consumer = kafka.consumer({ groupId: 'demand-service' })

const topicsToProduce = ['trip-status', 'demand-booking'] as const
const topicsToSubscribe = [
    'supply-suggesting',
    'trip-tracking',
    'accept-booking',
    'driver-come',
    'driver-ongoing',
    'trip-finish',
] as const
const topicToSubscribeHandlers: Record<
    (typeof topicsToSubscribe)[number],
    // eslint-disable-next-line @typescript-eslint/ban-types
    Function
> = {
    'accept-booking': acceptedBookingTopiHandler,
    'supply-suggesting': supplySuggestingTopicHandler,
    'trip-tracking': tripTrackingTopicHandler,
    'driver-come': driverComeTopicHandler,
    'driver-ongoing': driverOnGoingTopicHandler,
    'trip-finish': tripFinishTopicHandler,
}

function supplySuggestingTopicHandler(data: any) {
    console.log(
        'Got a new message from supply-suggesting topic: ',
        JSON.stringify(data, null, 2)
    )

    const io = socketIO.getIO()

    if (
        io.customer_sockets &&
        data.tripInfo.customerId in io.customer_sockets
    ) {
        const customerInfo = io.customer_sockets[data.tripInfo.customerId]
        customerInfo.socket?.emit('locating-driver', data.drivers)
    }
}

function acceptedBookingTopiHandler(data: any) {
    console.log(
        'Got a new message from accept-booking topic: ',
        JSON.stringify(data, null, 2)
    )

    const io = socketIO.getIO()

    if (
        io.customer_sockets &&
        data.tripInfo.customerId in io.customer_sockets
    ) {
        const customerInfo = io.customer_sockets[data.tripInfo.customerId]
        // customerInfo.socket?.emit('state-change', data)
        const newdata = {
            tripInfo: {
                ...data.tripInfo,
                rotate: data.rotate,
                directions: data.directions,
            },
        }
        customerInfo.socket?.emit('driver-accepted', newdata)
        console.log('EMIT DRIVERT ACCEPTED')
    }
}

function driverComeTopicHandler(data: any) {
    console.log(
        'Got a new message from driver-come topic: ',
        JSON.stringify(data, null, 2)
    )

    const io = socketIO.getIO()

    if (
        io.customer_sockets &&
        data.tripInfo.customerId in io.customer_sockets
    ) {
        const customerInfo = io.customer_sockets[data.tripInfo.customerId]
        const newdata = {
            tripInfo: {
                ...data.tripInfo,
                rotate: data.rotate,
                directions: data.directions,
            },
        }
        customerInfo.socket?.emit('driver-come', newdata)
        // customerInfo.socket?.emit('driver-accepted', data)
    }
}

function driverOnGoingTopicHandler(data: any) {
    console.log(
        'Got a new message from driver-ongoing topic: ',
        JSON.stringify(data, null, 2)
    )

    const io = socketIO.getIO()

    if (
        io.customer_sockets &&
        data.tripInfo.customerId in io.customer_sockets
    ) {
        const customerInfo = io.customer_sockets[data.tripInfo.customerId]
        const newdata = {
            tripInfo: {
                ...data.tripInfo,
                rotate: data.rotate,
                directions: data.directions,
            },
        }
        customerInfo.socket?.emit('driver-ongoing', newdata)
        // customerInfo.socket?.emit('driver-accepted', data)
    }
}

function tripFinishTopicHandler(data: any) {
    console.log(
        'Got a new message from driver-ongoing topic: ',
        JSON.stringify(data, null, 2)
    )

    const io = socketIO.getIO()

    if (
        io.customer_sockets &&
        data.tripInfo.customerId in io.customer_sockets
    ) {
        const customerInfo = io.customer_sockets[data.tripInfo.customerId]
        const newdata = {
            tripInfo: {
                ...data.tripInfo,
                rotate: data.rotate,
                directions: data.directions,
            },
        }
        customerInfo.socket?.emit('trip-finish', newdata)
        // customerInfo.socket?.emit('driver-accepted', data)
    }
}

function tripTrackingTopicHandler(data: any) {
    // console.log(
    //     'Got a new message from trip-tracking topic: ',
    //     JSON.stringify(data, null, 2)
    // )

    const io = socketIO.getIO()

    if (
        io.customer_sockets &&
        data.tripInfo.customerId in io.customer_sockets
    ) {
        const customerInfo = io.customer_sockets[data.tripInfo.customerId]
        const newdata = {
            tripInfo: {
                ...data.tripInfo,
                rotate: data.rotate,
                directions: data.directions,
            },
        }
        customerInfo.socket?.emit('driver-moving', newdata)
        // customerInfo.socket?.emit('driver-accepted', data)
    }
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
