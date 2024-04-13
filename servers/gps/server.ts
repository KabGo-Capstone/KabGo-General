import socketIO from 'common/socket'
import Application from './common/app'
import * as allController from './common/controllers'
import * as allEvent from './common/events'
import Logger from './common/utils/logger'
import { IDriverSocket } from 'common/interfaces/driver.socket'
import { latLngToCell } from 'h3-js'
import H3Geometry from 'common/utils/h3.geometry'
import {
    demandBookingList,
    disconnectConsumerFromKafKa,
    disconnectProducerFromKafka,
    driverList,
    sendMessage,
} from 'common/utils/kafka'

process.on('uncaughtException', (err: Error) => {
    Logger.error('Uncaught Exception. Shutting down...')
    Logger.error(err.name, err.message, err.stack)

    setTimeout(() => {
        disconnectProducerFromKafka()
        disconnectConsumerFromKafKa()
        process.exit(1)
    }, 3000)
})

const app = new Application({
    controllers: Object.values(allController),
    events: Object.values(allEvent),
    redisConnection: {
        uri: process.env.REDIS_URI as string,
    },
    mongoConnection: {
        uri: process.env.MONGO_URI as string,
    },
    cloudinaryConnection: {
        cloud_name: process.env.CLOUDINARY_CLOUD_NAME as string,
        api_key: process.env.CLOUDINARY_API_KEY as string,
        api_secret: process.env.CLOUDINARY_API_SECRET as string,
    },
})

const server = app.run(() => {
    setInterval(() => {
        const drivers = driverList
        const bookings = demandBookingList

        const map: {
            [key: string]: any[]
        } = {}

        for (const key in drivers) {
            const driver = drivers[key]

            const { lat, lng } = driver.position

            const h3Index = latLngToCell(lat, lng, 9)

            if (!map[h3Index]) map[h3Index] = []

            map[h3Index].push(driver)
        }

        for (const customerKey in bookings) {
            const trip = bookings[customerKey]

            if (trip.status !== 'LOCATING') continue

            const nearestDriver = H3Geometry.kRingResults(
                map,
                {
                    lat: trip.origin.lat,
                    lng: trip.origin.lng,
                },
                1.5
            )

            const top5FreeDriver = nearestDriver.slice(0, 5).map((el) => {
                return el
            })

            if (top5FreeDriver.length > 0) {
                sendMessage(
                    'supply-suggesting',
                    JSON.stringify({
                        tripInfo: {
                            ...trip,
                        },
                        drivers: top5FreeDriver,
                    })
                )
                // console.log('sent message to queue')
            } else {
                sendMessage(
                    'supply-suggesting',
                    JSON.stringify({
                        tripInfo: {
                            ...trip,
                        },
                        drivers: [],
                    })
                )
            }
        }
    }, 2000)
})

process.on('unhandledRejection', (err: Error) => {
    Logger.error('Unhandled Rejection. Shutting down...')
    Logger.error(err.name, err.message, err.stack)

    setTimeout(() => {
        server.close(() => {
            disconnectProducerFromKafka()
            disconnectConsumerFromKafKa()
            process.exit(1)
        })
    }, 3000)
})

export default server
