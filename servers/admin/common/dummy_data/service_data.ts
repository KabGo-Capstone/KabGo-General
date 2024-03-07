import ServiceModel, { IService } from 'common/models/service.model';

export const getServiceData = async () => {
    const data: IService[] = [];
    const getDataFromDB = await ServiceModel.find();
    for (let i = 0; i < getDataFromDB.length; i++) {
        data.push({
            id: getDataFromDB[i].id,
            name: getDataFromDB[i].name,
            description: getDataFromDB[i].description,
            basePrice: getDataFromDB[i].basePrice,
        })
    }
    return data;
}
