import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import Logger from '../utils/logger'
import chalk from 'chalk'
import { sendMessage } from 'common/utils/kafka'

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

        for (const driverKey in io.driver_sockets) {
            const driver = io.driver_sockets[driverKey]

            if (driver.socket.id === socket.id) {
                sendMessage(
                    'supply-info',
                    JSON.stringify({
                        status: 'OFF',
                        driverId: driver.driverId,
                    })
                )
                delete io.driver_sockets[driverKey]
                break
            }
        }
    }
}

export default new DisconnectEvent()
