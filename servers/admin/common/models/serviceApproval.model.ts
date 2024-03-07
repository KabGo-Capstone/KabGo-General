import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

export interface IServiceApproval {
    id: string,
    supplyID: string,
    serviceID: string,
    vehicleID: string,
    status: string,
    createdDate: string,
    driverLicense: string,
    personalImg: string,
    identityImg: string,
    vehicleImg: string,
    currentAddress: string,
}

const ServiceApprovalSchema = new mongoose.Schema<IServiceApproval>(
    {
        id: { type: String },
        supplyID: { type: String },
        serviceID: { type: String },
        vehicleID: { type: String },
        status: { type: String },
        createdDate: { type: String },
        driverLicense: { type: String },
        personalImg: { type: String },
        identityImg: { type: String },
        vehicleImg: { type: String },
        currentAddress: { type: String },
    },
)

const ServiceApprovalModel = mongoose.model<IServiceApproval>('service_approval', ServiceApprovalSchema)

export default ServiceApprovalModel
