import { Socket } from 'socket.io'

interface Coord {
    lat: number
    lng: number
}

interface Position {
    coor: Coord
    rad: number
}

export interface IDriverSocket {
    id: string
    name: string
    socket: Socket
    position: Position
    role: string
    customer?: string
}
