import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import { sendMessage } from 'common/utils/kafka'
import axios from 'axios'

class AcceptTripEvent implements IEvent {
    public readonly event: string = 'accept-trip'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onAcceptance
    }

    private async onAcceptance(io: Server, socket: Socket, data: any) {
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
        newdata.tripInfo.status = 'ACCEPTED'
        axios
            .post(`${process.env.TRIP_URL}/accept-driver`, {
                tripInfo: newdata.tripInfo,
            })
            .then(async (res) => {
                await sendMessage('accept-booking', JSON.stringify(newdata))
            })
            .catch((err) => console.log(err))
    }
}

export default new AcceptTripEvent()
