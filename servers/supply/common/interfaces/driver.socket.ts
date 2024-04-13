import { Socket } from 'socket.io'

export interface IDriverSocket {
    driverId: string
    driver: {
        firstname: string
        lastname: string
        phonenumber: string
        avatar: string
    }
    service: string
    vehicle: {
        name: string
        identity_number: string
        color: string
        brand: string
    }
    position: {
        lat: number
        lng: number
        bearing: number
    }
    status: string
    role: string
    socket: Socket
}
