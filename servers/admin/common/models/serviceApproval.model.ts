import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

export interface IServiceApproval {
    id: string,
    supplyID: string,
    serviceID: string,
    vehicleID: string,
    status: string,
    createdDate: string,
    driverLicenseFrontsight: string,
    driverLicenseBacksight: string,
    personalImg: string,
    identityImgFrontsight: string,
    identityImgBacksight: string,
    vehicleImgFrontsight: string,
    vehicleImgBacksight: string,
    vehicleImgLeftsight: string,
    vehicleImgRightsight: string,
    currentAddress: string,
    vehicleRegistrationFrontsight: string,
    vehicleRegistrationBacksight: string,
    vehicleInsuranceFrontsight: string,
    vehicleInsuranceBacksight: string,
    identityDate: string,
    identityLocation: string
}

const ServiceApprovalSchema = new mongoose.Schema<IServiceApproval>(
    {
        id: { type: String },
        supplyID: { type: String },
        serviceID: { type: String },
        vehicleID: { type: String },
        status: { type: String },
        createdDate: { type: String },
        driverLicenseFrontsight: { type: String },
        driverLicenseBacksight: { type: String },
        personalImg: { type: String },
        identityImgFrontsight: { type: String },
        identityImgBacksight: { type: String },
        vehicleImgFrontsight: { type: String },
        vehicleImgBacksight: { type: String },
        vehicleImgLeftsight: { type: String },
        vehicleImgRightsight: { type: String },
        currentAddress: { type: String },
        vehicleRegistrationFrontsight:{ type: String },
        vehicleRegistrationBacksight: { type: String },
        vehicleInsuranceFrontsight: { type: String },
        vehicleInsuranceBacksight: { type: String },
        identityDate: { type: String },
        identityLocation: { type: String }
    },
)

const ServiceApprovalModel = mongoose.model<IServiceApproval>('service_approval', ServiceApprovalSchema)

export default ServiceApprovalModel
