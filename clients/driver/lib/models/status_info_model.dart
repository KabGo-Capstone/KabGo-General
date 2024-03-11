// ignore_for_file: public_member_api_docs, sort_constructors_first
class StatusInfoModel {
  bool isCompletedImgPerson;
  bool isCompletedID;
  bool isCompletedLicense;
  bool isCompletedEmergency;
  bool isCompletedImgVehicle;
  bool isCompletedRegisterVehicle;
  bool isCompletedInsurance;
  bool isCompletedEmail;

  StatusInfoModel({
    this.isCompletedImgPerson = false,
    this.isCompletedID = false,
    this.isCompletedLicense = false,
    this.isCompletedEmergency = false,
    this.isCompletedImgVehicle = false,
    this.isCompletedRegisterVehicle = false,
    this.isCompletedInsurance = false,
    this.isCompletedEmail = false,
  });
}
