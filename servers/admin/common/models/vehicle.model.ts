import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

export interface IVehicle {
    id: string,
    name: string,
    identityNumber: string,
    color: string,
    brand: string,
}

const VehicleSchema = new mongoose.Schema<IVehicle>(
    {
        id: { type: String },
        name: { type: String },
        identityNumber: { type: String },
        color: { type: String },
        brand: { type: String },
    },
)

const VehicleModel = mongoose.model<IVehicle>('vehicle', VehicleSchema)

export default VehicleModel
