import socketClient, { Socket } from 'socket.io-client'

class SocketClient {
    private static instance?: SocketClient
    private socketClient: Socket | null

    private constructor() {
        this.socketClient = null
    }

    public static getInstance(): SocketClient {
        return this.instance ?? (this.instance = new this())
    }

    public init(connectionStr: string): Socket {
        return (
            this.socketClient ??
            (this.socketClient = socketClient(connectionStr))
        )
    }

    public client(): Socket {
        if (!this.socketClient) {
            throw new Error('Socket instance not initialized')
        }
        return this.socketClient
    }
}

const clientSocket = SocketClient.getInstance()

export default clientSocket
