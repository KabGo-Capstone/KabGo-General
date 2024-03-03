interface IDriver {
    createdDate: string;
    currentAddress: string;
    driverLicense: string;
    id: string;
    identityImg: string;
    personalImg: string;
    service: {
        basePrice: string;
        description: string;
        id: string;
        name: string;
    };
    serviceID: string;
    vehicle: {
        brand: string;
        color: string;
        id: string;
        name: string;
    }
    vehicleID: string;
    vehicleImg: string;
    status: string;
    supply: {
        id: string;
        gender: string;
        email: string;
        password: string;
        dob: string;
        verified: boolean;
        avatar: string;
        firstName: string;
        lastName: string;
        address: string;
    };
}
export default IDriver;