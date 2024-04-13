import express from 'express'
import socketIO from 'common/socket'
import socketClient, { Socket } from 'socket.io-client'

const args = process.argv.slice(2)

const numberofCustomer = Number(args[0]) ?? 1
const latCus = Number(args[1])
const lngCus = Number(args[2])

interface Coord {
    lat: number
    lng: number
}

interface Position {
    coor: Coord
    rad: number
}

function random_gps_path_around_point(
    point: Coord,
    range: number,
    num_points: number
) {
    const points = []

    for (let i = 0; i < num_points; i++) {
        const offset_lat = (Math.random() - 0.5) * 2 * range
        const offset_lng = (Math.random() - 0.5) * 2 * range

        const new_lat = point.lat + offset_lat
        const new_lng = point.lng + offset_lng

        const angle = Math.random() * 360

        points.push({
            coor: { lat: new_lat, lng: new_lng },
            rad: angle,
        })
    }
    return points
}

class Application {
    private app: express.Application
    private socketClient: Socket
    private driverCenter: Position

    constructor() {
        this.app = express()

        this.socketClient = socketClient('ws://127.0.0.1:5002', {
            autoConnect: false,
        })

        this.driverCenter = random_gps_path_around_point(
            { lat: latCus, lng: lngCus },
            0.001,
            1
        )[0]
    }

    setup() {
        this.app.use(express.json())
        this.app.use(express.urlencoded({ extended: true }))
    }

    listen(portIndex: number) {
        const port = 30000 + portIndex

        const user = {
            driverId: `driver-${portIndex}`,
            firstname: 'John',
            lastname: 'Smith',
            avatar: '',
            service: 'Oto 4 chỗ',
            status: 'FREE',
            vehicle: {
                name: 'Honda Wave RSX',
                identity_number: '68S164889',
                color: 'Đen',
                brand: 'Honda',
            },
            position: {
                lat: 10.762972610667733,
                lng: 106.68250385385542,
                bearing: 1,
            },
            role: 'driver',
        }

        const server = this.app.listen(port, () => {
            this.socketClient.connect()

            this.socketClient.on('connect', () => {
                console.log(`Client ${port} connect to supply server`)

                this.socketClient.emit('join-server', {
                    ...user,
                })

                setInterval(() => {
                    const pos = random_gps_path_around_point(
                        { lat: latCus, lng: lngCus },
                        0.005,
                        1
                    )[0]
                    this.socketClient.emit('locating', {
                        ...user,
                        position: {
                            lat: pos.coor.lat,
                            lng: pos.coor.lng,
                            bearing: pos.rad,
                        },
                    })
                }, 3000)

                // this.socketClient.emit('coordinator', user)
            })

            this.socketClient.on('demand-suggesting', (data: any) => {
                console.log(user.driverId, data)
                setTimeout(() => {
                    this.socketClient.emit('accept-trip', {
                        tripInfo: {
                            ...data.tripInfo,
                            status: 'ACCEPTED',
                            driverId: user.driverId,
                        },
                        driverInfo: {
                            ...user,
                        },
                    })
                }, 3000)
                user.status = 'BUSY'
            })

            socketIO.init(server)

            console.log(`Server is running on port ${port}`)
        })

        this.app.use('/', (req, res, next) => {
            return res.json({
                status: 200,
                port: port,
                message: 'Hello World',
            })
        })

        return this.app
    }
}

for (let i = 0; i < numberofCustomer; ++i) {
    const myapp = new Application()
    myapp.setup()
    myapp.listen(i)
}
