import { Server, Socket } from 'socket.io'
import IEvent from '../interfaces/event'
import { latLngToCell } from 'h3-js'
import { IDriverSocket } from 'common/interfaces/driver.socket'
import H3Geometry from 'common/utils/h3.geometry'

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

    // change to message brokers
    private async onCoordinator(io: Server, socket: Socket, user: any) {
        // không cần user nữa mà sẽ lấy user dựa vào 2 queue là demand-booking và supply-info, ko cần if else và bỏ socket (socket này là giả lập cho queue)
        if (user.role === 'customer') {
            io.customer_sockets = {
                ...io.customer_sockets,
                [user.id]: {
                    ...user,
                    socket: socket, // bỏ
                },
            }
        } else {
            io.driver_sockets = {
                ...io.driver_sockets,
                [user.id]: {
                    ...user,
                    socket: socket, // bỏ
                },
            }
        }
    }
}

export default new CoordinatorEvent()
