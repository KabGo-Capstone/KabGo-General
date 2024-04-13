import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import Logger from '../utils/logger'
import chalk from 'chalk'

class DisconnectEvent implements IEvent {
    public readonly event: string = 'disconnect'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onDisconnect
    }

    private async onDisconnect(io: Server, socket: Socket) {
        Logger.info(`${chalk.red('Disconnected')} - Socket ID: ${socket.id}`)

        for (const customerKey in io.customer_sockets) {
            const customer = io.customer_sockets[customerKey]

            if (customer.socket.id === socket.id) {
                delete io.customer_sockets[customerKey]
                break
            }
        }
    }
}

export default new DisconnectEvent()
