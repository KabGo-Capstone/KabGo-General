import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import { sendMessage } from 'common/utils/kafka'
import axios from 'axios'

class LocateDriverEvent implements IEvent {
    public readonly event: string = 'locate-driver'
    public readonly listener: (
        io: Server,
        socket: Socket,
        ...args: any[]
    ) => void

    constructor() {
        this.listener = this.onLocateDriver
    }

    private async onLocateDriver(io: Server, socket: Socket, tripInfo: any) {
        tripInfo.status = 'LOCATING'
        axios
            .post(`${process.env.TRIP_URL}/locate-driver`, {
                tripInfo: tripInfo,
            })
            .then(async (res) => {
                const tripInfo = res.data.data
                await sendMessage('demand-booking', JSON.stringify(tripInfo))
            })
            .catch((err) => console.log(err.response))
        // sendMessage('locating-trip', JSON.stringify(tripInfo))
    }
}

export default new LocateDriverEvent()
