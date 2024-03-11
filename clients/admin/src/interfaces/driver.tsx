interface IDriver {
    createdDate: string;
    currentAddress: string;
    driverLicenseBacksight: string;
    driverLicenseFrontsight: string;
    id: string;
    identityDate: string;
    identityImgBacksight: string;
    identityImgFrontsight: string;
    identityLocation: string;
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
        identityNumber: string;
    }
    vehicleID: string;
    vehicleImgBacksight: string;
    vehicleImgFrontsight: string;
    vehicleImgLeftsight: string;
    vehicleImgRightsight: string;
    vehicleInsuranceBacksight: string;
    vehicleInsuranceFrontsight: string;
    vehicleRegistrationFrontsight: string;
    vehicleRegistrationBacksight: string;
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
        city: string;
        phoneNumber: string;
        referralCode: string;
    };
}
export default IDriver;