import mongoose from 'mongoose'

export interface ITrip {
    _id: mongoose.Types.ObjectId
    tripId?: string
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
    revision: number
    price: string
    couponId?: string
    serviceId: string
    createdAt: Date
}

const TripSchema = new mongoose.Schema<ITrip>(
    {
        _id: mongoose.Types.ObjectId,
        driverId: { type: String },
        customerId: { type: String, required: true },
        status: { type: String, required: true },
        distance: { type: String, required: true },
        eta: { type: String, required: true },
        origin: {
            lat: { type: Number, required: true },
            lng: { type: Number, required: true },
            description: { type: String, required: true },
        },
        destination: {
            lat: { type: Number, required: true },
            lng: { type: Number, required: true },
            description: { type: String, required: true },
        },
        revision: { type: Number, required: true, default: 0 },
        price: { type: String, required: true },
        couponId: { type: String },
        serviceId: { type: String, required: true },
        createdAt: { type: Date, default: Date.now },
    },
    {
        toJSON: {
            virtuals: true,
            versionKey: false,
        },
        toObject: {
            virtuals: true,
            versionKey: false,
        },
    }
)

TripSchema.virtual('tripId').get(function () {
    return this._id.toHexString()
})

const TripModel = mongoose.model<ITrip>('Trip', TripSchema)

export default TripModel
