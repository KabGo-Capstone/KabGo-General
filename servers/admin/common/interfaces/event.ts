import { Server, Socket } from 'socket.io'

interface IEvent {
    readonly event: string
    readonly listener: (io: Server, socket: Socket, ...args: any[]) => void
}

export default IEvent
