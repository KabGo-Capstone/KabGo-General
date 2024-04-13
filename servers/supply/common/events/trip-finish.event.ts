import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import { sendMessage } from 'common/utils/kafka'
import axios from 'axios'

class TripFinishEvent implements IEvent {
    public readonly event: string = 'trip-finish'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onFinish
    }

    private async onFinish(io: Server, socket: Socket, data: any) {
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
        newdata.tripInfo.status = 'FINISHED'
        axios
            .post(`${process.env.TRIP_URL}/trip-finish`, {
                tripInfo: newdata.tripInfo,
            })
            .then(async (res) => {
                await sendMessage('trip-finish', JSON.stringify(newdata))
            })
            .catch((err) => console.log(err))
    }
}

export default new TripFinishEvent()
