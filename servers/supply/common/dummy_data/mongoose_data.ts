import DriverModel, { IDriver } from '../models/driver.model'

export const getSupplies = async () => {
    const DRIVERS: IDriver[] = []
    const getDriver = await DriverModel.find()
    for (const element of getDriver) {
        DRIVERS.push({
            id: element.id,
            firstName: element.firstName,
            lastName: element.lastName,
            phoneNumber: element.phoneNumber,
            password: element.password,
            dob: element.dob,
            gender: element.gender,
            address: element.address,
            verified: element.verified,
            avatar: element.avatar,
            email: element.email,
            referralCode: element.referralCode,
            city: element.city,
            googleId: element.googleId,
        })
    }
    return DRIVERS
}
