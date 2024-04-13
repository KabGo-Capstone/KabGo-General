export interface DriverState {
    driverId: string
    driverActive: boolean
    activeAt: Date
    coordination?: {
        latitude: number
        longitude: number
        bearing: number
    }
    customerId?: string
    tripId?: string
}
