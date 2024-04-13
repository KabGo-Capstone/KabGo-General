export type TripCreateCommand = {
    tripId: string
    customerId: string
    status: string
    distance: string
    eta: string
    origin: {
        lat: number
        lng: number
        description: string
    }
    destination: {
        lat: number
        lng: number
        description: string
    }
    price: string
    serviceId: string
    createdAt: Date
}
