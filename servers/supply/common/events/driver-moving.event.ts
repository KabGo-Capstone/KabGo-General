import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import { sendMessage } from 'common/utils/kafka'
import axios from 'axios'

class DriverMovingEvent implements IEvent {
    public readonly event: string = 'driver-moving'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onMoving
    }

    private async onMoving(io: Server, socket: Socket, data: any) {
        const data2 = JSON.parse(data)
        const driver = JSON.parse(data2.driver)
        const newdata = {
            tripInfo: {
                ...data2.trip_info.customer_infor,
                driver: {
                    ...driver,
                },
                driverId: driver.id,
            },
            rotate: data2.rotate,
            directions: data2.directions,
        }

        sendMessage('trip-tracking', JSON.stringify(newdata))
    }
}

export default new DriverMovingEvent()
