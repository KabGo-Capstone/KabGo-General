import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

export interface IDriver {
    id: string,
    firstName: string,
    lastName: string,
    password: string,
    dob: string,
    gender: string,
    address: string,
    verified: boolean,
    avatar: string,
    email: string,
}

const DriverSchema = new mongoose.Schema<IDriver>(
    {
        id: { type: String },
        firstName: { type: String },
        lastName: { type: String },
        password: { type: String },
        dob: { type: String },
        gender: { type: String },
        address: { type: String },
        verified: { type: Boolean },
        avatar: { type: String },
        email: { type: String },
    },

)

const DriverModel = mongoose.model<IDriver>('driver', DriverSchema)

export default DriverModel
