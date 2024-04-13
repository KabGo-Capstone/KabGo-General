import { Socket } from 'socket.io'

export interface ICustomerSocket {
    customerId: string
    customer: {
        firstname: string
        lastname: string
        phonenumber: string
        avatar: string
    }
    role: string
    socket: Socket
}
