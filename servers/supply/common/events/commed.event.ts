import IEvent from 'common/interfaces/event'
import { sendMessage } from 'common/utils/kafka'
import { Server, Socket } from 'socket.io'

class CommedTripEvent implements IEvent {
    public readonly event: string = 'come-trip'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onCancelled
    }

    private async onCancelled(io: Server, socket: Socket, data: any) {}
}

export default new CommedTripEvent()
