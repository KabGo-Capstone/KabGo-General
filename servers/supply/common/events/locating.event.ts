import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import { sendMessage } from 'common/utils/kafka'

class LocatingEvent implements IEvent {
    public readonly event: string = 'locating'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onLocating
    }

    private async onLocating(io: Server, socket: Socket, driverInfo: any) {
        sendMessage('supply-info', JSON.parse(driverInfo))
    }
}

export default new LocatingEvent()
