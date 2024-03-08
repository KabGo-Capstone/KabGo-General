import DriverModel, { IDriver } from '../models/driver.model';

export const getSupplies = async () => {
    const DRIVERS: IDriver[] = [];
    const getDriver = await DriverModel.find();
    for (let i = 0; i < getDriver.length; i++) {
        DRIVERS.push({
            id: getDriver[i].id,
            firstName: getDriver[i].firstName,
            lastName: getDriver[i].lastName,
            password: getDriver[i].password,
            dob: getDriver[i].dob,
            gender: getDriver[i].gender,
            address: getDriver[i].address,
            verified: getDriver[i].verified,
            avatar: getDriver[i].avatar,
            email: getDriver[i].email,
        })
    }
    return DRIVERS;
}
