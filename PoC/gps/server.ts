import socketIO from 'common/socket'
import Application from './common/app'
import * as allController from './common/controllers'
import * as allEvent from './common/events'
import Logger from './common/utils/logger'
import { IDriverSocket } from 'common/interfaces/driver.socket'
import { latLngToCell } from 'h3-js'
import H3Geometry from 'common/utils/h3.geometry'
import { demandBookingList, disconnectConsumerFromKafKa, disconnectProducerFromKafka, driverList, sendMessage } from 'common/utils/kafka'

process.on('uncaughtException', (err: Error) => {
    Logger.error('Uncaught Exception. Shutting down...')
    Logger.error(err.name, err.message, err.stack)

    setTimeout(() => {
        disconnectProducerFromKafka();
        disconnectConsumerFromKafKa();
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
    // const io = socketIO.getIO()
    // setInterval(() => { // lấy từ memory chứa danh sách tài xế và danh sách khách hàng, sau đó tìm  5 tài xế gần nhất cho khách hàng
    //     // 
    //     const drivers = io.driver_sockets

    //     const map: {
    //         [key: string]: IDriverSocket[]
    //     } = {}

    //     for (const key in drivers) {
    //         const driver = drivers[key]

    //         const { lat, lng } = driver.position.coor

    //         const h3Index = latLngToCell(lat, lng, 9)

    //         if (!map[h3Index]) map[h3Index] = []

    //         map[h3Index].push(driver)
    //     }

    //     for (const customerKey in io.customer_sockets) {
    //         const customer = io.customer_sockets[customerKey]

    //         const nearestDriver = H3Geometry.kRingResults(
    //             map,
    //             customer.position.coor,
    //             1.5
    //         ) // truyền vào gps khách hàng, một map chứa các tài xế gồm h3index của họ -> output: 5 tài xế gần nhất với gps khách hàng

    //         const top5FreeDriver = nearestDriver.slice(0, 5).map((el) => {
    //             delete el.socket
    //             return el
    //         })

    //         customer.socket.emit('near-driver', {
    //             customer: customer.id,
    //             drivers: top5FreeDriver,
    //         }) // thay bước này thành bước bắn lên queue supply-suggest là top 5 tài xế gần nhất cho 1 thằng khách hàng
    //     }
    // }, 2000)

    setInterval(() => { // lấy từ memory chứa danh sách tài xế và danh sách khách hàng, sau đó tìm  5 tài xế gần nhất cho khách hàng
        const drivers = driverList;
        const bookings = demandBookingList;

        const map: {
            [key: string]: any[]
        } = {}

        for (const key in drivers) {
            const driver = drivers[key]

            const { lat, lng } = driver.position.coor

            const h3Index = latLngToCell(lat, lng, 9)

            if (!map[h3Index]) map[h3Index] = []

            map[h3Index].push(driver)
        }

        for (const customerKey in bookings) {
            const customer = bookings[customerKey]

            const nearestDriver = H3Geometry.kRingResults(
                map,
                customer.position.coor,
                1.5
            ) // truyền vào gps khách hàng, một map chứa các tài xế gồm h3index của họ -> output: 5 tài xế gần nhất với gps khách hàng

            const top5FreeDriver = nearestDriver.slice(0, 5).map((el) => {
                return el
            })

            // customer.socket.emit('near-driver', {
            //     customer: customer.id,
            //     drivers: top5FreeDriver,
            // }) // thay bước này thành bước bắn lên queue supply-suggest là top 5 tài xế gần nhất cho 1 thằng khách hàng

            sendMessage('supply-suggesting', JSON.stringify({
                customer: customer.id,
                drivers: top5FreeDriver,
            }));
            console.log('sent message to queue');
        }
    }, 2000)

})

process.on('unhandledRejection', (err: Error) => {
    Logger.error('Unhandled Rejection. Shutting down...')
    Logger.error(err.name, err.message, err.stack)

    setTimeout(() => {
        server.close(() => {
            disconnectProducerFromKafka();
            disconnectConsumerFromKafKa();
            process.exit(1)
        })
    }, 3000)
})

export default server
