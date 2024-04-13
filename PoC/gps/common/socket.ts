import { Server, ServerOptions } from 'socket.io'
import http from 'http'
import CorsCustomOptions from './configs/cors.config'

class SocketIO {
    private static instance?: SocketIO
    private io: Server | null

    private constructor() {
        this.io = null
    }

    public static getInstance(): SocketIO {
        return this.instance ?? (this.instance = new this())
    }

    public init(httpServer: http.Server, options?: ServerOptions): Server {
        return (
            this.io ??
            (this.io = new Server(httpServer, {
                cors: CorsCustomOptions,
                transports: ['polling', 'websocket'],
                allowEIO3: true,
                ...options,
            }))
        )
    }

    public getIO(): Server {
        if (!this.io) {
            throw new Error('Socket instance not initialized')
        }
        return this.io
    }
}

const socketIO = SocketIO.getInstance()

export default socketIO
