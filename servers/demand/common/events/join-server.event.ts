import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import axios from 'axios'

class JoinServerEvent implements IEvent {
    public readonly event: string = 'join-server'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onJoined
    }

    private async onJoined(io: Server, socket: Socket, customerInfo: any) {
        io.customer_sockets = {
            ...io.customer_sockets,
            [customerInfo.customerId]: {
                ...customerInfo,
                role: 'customer',
                socket: socket,
            },
        }

        axios
            .get(
                `${process.env.TRIP_URL}/trip-status?customer=${customerInfo.customerId}`
            )
            .then((res) => {
                socket.emit(
                    'state-change',
                    res.data.data ? res.data.data : null
                )
            })
            .catch((err) => console.log(err))
    }
}

export default new JoinServerEvent()
