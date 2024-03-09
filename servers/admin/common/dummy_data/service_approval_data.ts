import ServiceApprovalModel, { IServiceApproval } from '../models/serviceApproval.model';

export const getServiceApprovalData = async () => {
    const data: IServiceApproval[] = [];
    const getDataFromDB = await ServiceApprovalModel.find();
    for (let i = 0; i < getDataFromDB.length; i++) {
        data.push({
            id: getDataFromDB[i].id,
            supplyID: getDataFromDB[i].supplyID,
            serviceID: getDataFromDB[i].serviceID,
            vehicleID: getDataFromDB[i].vehicleID,
            status: getDataFromDB[i].status,
            createdDate: getDataFromDB[i].createdDate,
            driverLicenseFrontsight: getDataFromDB[i].driverLicenseFrontsight,
            driverLicenseBacksight: getDataFromDB[i].driverLicenseBacksight,
            personalImg: getDataFromDB[i].personalImg,
            identityImgFrontsight: getDataFromDB[i].identityImgFrontsight,
            identityImgBacksight: getDataFromDB[i].identityImgBacksight,
            vehicleImgFrontsight: getDataFromDB[i].vehicleImgFrontsight,
            vehicleImgBacksight: getDataFromDB[i].vehicleImgBacksight,
            vehicleImgLeftsight: getDataFromDB[i].vehicleImgLeftsight,
            vehicleImgRightsight: getDataFromDB[i].vehicleImgRightsight,
            currentAddress: getDataFromDB[i].currentAddress,
            vehicleRegistrationFrontsight: getDataFromDB[i].vehicleRegistrationFrontsight,
            vehicleRegistrationBacksight: getDataFromDB[i].vehicleRegistrationBacksight,
            vehicleInsuranceFrontsight: getDataFromDB[i].vehicleInsuranceFrontsight,
            vehicleInsuranceBacksight: getDataFromDB[i].vehicleInsuranceBacksight,
        })
    }
    return data;
}
