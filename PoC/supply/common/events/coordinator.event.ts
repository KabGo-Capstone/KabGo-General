import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import clientSocket from 'common/socket.client'
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
        io.driver_sockets = {
            ...io.driver_sockets,
            [user.id]: {
                ...user,
                socket: socket,
            },
        }

        // clientSocket.client().emit('coordinator', user) // change it to message brokers
        sendMessage('supply-info', JSON.stringify(user));
    }
}

export default new CoordinatorEvent()
