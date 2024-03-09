import VehicleModel, { IVehicle } from '../models/vehicle.model';

export const getVehicleData = async () => {
    const data: IVehicle[] = [];
    const getDataFromDB = await VehicleModel.find();
    for (let i = 0; i < getDataFromDB.length; i++) {
        data.push({
            id: getDataFromDB[i].id,
            name: getDataFromDB[i].name,
            identityNumber: getDataFromDB[i].identityNumber,
            color: getDataFromDB[i].color,
            brand: getDataFromDB[i].brand
        })
    }
    return data;
}
