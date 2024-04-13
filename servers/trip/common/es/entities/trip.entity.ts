export interface TripState {
    tripId: string
    driverId?: string
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
    couponId?: string
    serviceId: string
    createdAt: Date
}
