import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import { sendMessage } from 'common/utils/kafka'

class CoordinatorEvent implements IEvent {
    public readonly event: string = 'coordinator'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onCoordinator
    }

    private async onCoordinator(io: Server, socket: Socket, user: any) {
        io.customer_sockets = {
            ...io.customer_sockets,
            [user.id]: {
                ...user,
                socket: socket,
            },
        }

        console.log('user: ', user)

        // clientSocket.client().emit('coordinator', user) // change it to message brokers
        sendMessage('demand-booking', JSON.stringify(user)) // send user booking information to kafka topic 'demand-booking',
    }
}

export default new CoordinatorEvent()
