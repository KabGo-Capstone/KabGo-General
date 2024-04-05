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
        const angle_rad = (angle * Math.PI) / 180

        points.push({
            coor: { lat: new_lat, lng: new_lng },
            rad: angle_rad,
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
            id: `driver-${portIndex}`,
            name: `driver-${portIndex}`,
            position: this.driverCenter,
            role: 'driver',
        }

        const server = this.app.listen(port, () => {
            this.socketClient.connect()

            this.socketClient.on('connect', () => {
                console.log(`Client ${port} connect to supply server`)

                setInterval(() => {
                    this.socketClient.emit('coordinator', {
                        ...user,
                        position: random_gps_path_around_point(
                            { lat: latCus, lng: lngCus },
                            0.001,
                            1
                        )[0],
                    })
                }, 3000)

                // this.socketClient.emit('coordinator', user)
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
