import ServiceApprovalModel, { IServiceApproval } from 'common/models/serviceApproval.model';

export const getServiceApprovalData = async () => {
    let data: IServiceApproval[] = [];
    const getDataFromDB = await ServiceApprovalModel.find();
    for (let i = 0; i < getDataFromDB.length; i++) {
        data.push({
            id: getDataFromDB[i].id,
            supplyID: getDataFromDB[i].supplyID,
            serviceID: getDataFromDB[i].serviceID,
            vehicleID: getDataFromDB[i].vehicleID,
            status: getDataFromDB[i].status,
            createdDate: getDataFromDB[i].createdDate,
            driverLicense: getDataFromDB[i].driverLicense,
            personalImg: getDataFromDB[i].personalImg,
            identityImg: getDataFromDB[i].identityImg,
            vehicleImg: getDataFromDB[i].vehicleImg,
            currentAddress: getDataFromDB[i].currentAddress
        })
    }
    return data;
}
