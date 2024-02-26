import { Server, Socket } from 'socket.io'
import chalk from 'chalk'
import IEvent from '../interfaces/event'
import Logger from '../utils/logger'

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
    }
}

export default new DisconnectEvent()
