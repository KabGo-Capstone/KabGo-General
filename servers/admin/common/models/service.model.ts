import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

export interface IService {
    id: string,
    name: string,
    description: string,
    basePrice: number,
}

const ServiceSchema = new mongoose.Schema<IService>(
    {
        id: { type: String },
        name: { type: String },
        description: { type: String },
        basePrice: { type: Number },
    },
)

const ServiceModel = mongoose.model<IService>('service', ServiceSchema)

export default ServiceModel
