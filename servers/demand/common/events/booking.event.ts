import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import { sendMessage } from 'common/utils/kafka'
import axios from 'axios'

class BookingTripEvent implements IEvent {
    public readonly event: string = 'booking-trip'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onBooking
    }

    private async onBooking(io: Server, socket: Socket, tripInfo: any) {
        tripInfo.status = 'CREATED'
        axios
            .post(`${process.env.TRIP_URL}/create-trip`, {
                tripInfo: tripInfo,
            })
            .then((res) => {
                socket.emit('state-change', res.data.data)
            })
            .catch((err) => console.log(err))
    }
}

export default new BookingTripEvent()
