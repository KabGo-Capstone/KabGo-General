import 'package:driver/models/status_info_model.dart';
import 'package:riverpod/riverpod.dart';

class StatusNotifier extends StateNotifier<StatusInfoModel> {
  StatusNotifier() : super(StatusInfoModel());

  void setDriverModel(StatusInfoModel value) async {
    state = value;
  }

  void setStatusEmail(bool isCompleted) {
    StatusInfoModel statusModel = StatusInfoModel(
        isCompletedEmail: state.isCompletedEmail,
        isCompletedEmergency: state.isCompletedEmergency,
        isCompletedID: state.isCompletedID,
        isCompletedImgPerson: state.isCompletedImgPerson,
        isCompletedImgVehicle: state.isCompletedImgVehicle,
        isCompletedInsurance: state.isCompletedInsurance,
        isCompletedLicense: state.isCompletedLicense,
        isCompletedRegisterVehicle: state.isCompletedRegisterVehicle);
    statusModel.isCompletedEmail = isCompleted;
    state = statusModel;
  }

  void setEmergency(bool isCompleted) {
    StatusInfoModel statusModel = StatusInfoModel(
        isCompletedEmail: state.isCompletedEmail,
        isCompletedEmergency: state.isCompletedEmergency,
        isCompletedID: state.isCompletedID,
        isCompletedImgPerson: state.isCompletedImgPerson,
        isCompletedImgVehicle: state.isCompletedImgVehicle,
        isCompletedInsurance: state.isCompletedInsurance,
        isCompletedLicense: state.isCompletedLicense,
        isCompletedRegisterVehicle: state.isCompletedRegisterVehicle);
    statusModel.isCompletedEmergency = isCompleted;
    state = statusModel;
  }

  void setIdentity(bool isCompleted) {
    StatusInfoModel statusModel = StatusInfoModel(
        isCompletedEmail: state.isCompletedEmail,
        isCompletedEmergency: state.isCompletedEmergency,
        isCompletedID: state.isCompletedID,
        isCompletedImgPerson: state.isCompletedImgPerson,
        isCompletedImgVehicle: state.isCompletedImgVehicle,
        isCompletedInsurance: state.isCompletedInsurance,
        isCompletedLicense: state.isCompletedLicense,
        isCompletedRegisterVehicle: state.isCompletedRegisterVehicle);
    statusModel.isCompletedID = isCompleted;
    state = statusModel;
  }

  void setImgPerdon(bool isCompleted) {
    StatusInfoModel statusModel = StatusInfoModel(
        isCompletedEmail: state.isCompletedEmail,
        isCompletedEmergency: state.isCompletedEmergency,
        isCompletedID: state.isCompletedID,
        isCompletedImgPerson: state.isCompletedImgPerson,
        isCompletedImgVehicle: state.isCompletedImgVehicle,
        isCompletedInsurance: state.isCompletedInsurance,
        isCompletedLicense: state.isCompletedLicense,
        isCompletedRegisterVehicle: state.isCompletedRegisterVehicle);
    statusModel.isCompletedImgPerson = isCompleted;
    state = statusModel;
  }

  void setImgVehicle(bool isCompleted) {
    StatusInfoModel statusModel = StatusInfoModel(
        isCompletedEmail: state.isCompletedEmail,
        isCompletedEmergency: state.isCompletedEmergency,
        isCompletedID: state.isCompletedID,
        isCompletedImgPerson: state.isCompletedImgPerson,
        isCompletedImgVehicle: state.isCompletedImgVehicle,
        isCompletedInsurance: state.isCompletedInsurance,
        isCompletedLicense: state.isCompletedLicense,
        isCompletedRegisterVehicle: state.isCompletedRegisterVehicle);
    statusModel.isCompletedImgVehicle = isCompleted;
    state = statusModel;
  }

  void setInsurance(bool isCompleted) {
    StatusInfoModel statusModel = StatusInfoModel(
        isCompletedEmail: state.isCompletedEmail,
        isCompletedEmergency: state.isCompletedEmergency,
        isCompletedID: state.isCompletedID,
        isCompletedImgPerson: state.isCompletedImgPerson,
        isCompletedImgVehicle: state.isCompletedImgVehicle,
        isCompletedInsurance: state.isCompletedInsurance,
        isCompletedLicense: state.isCompletedLicense,
        isCompletedRegisterVehicle: state.isCompletedRegisterVehicle);
    statusModel.isCompletedInsurance = isCompleted;
    state = statusModel;
  }

  void setLicnese(bool isCompleted) {
    StatusInfoModel statusModel = StatusInfoModel(
        isCompletedEmail: state.isCompletedEmail,
        isCompletedEmergency: state.isCompletedEmergency,
        isCompletedID: state.isCompletedID,
        isCompletedImgPerson: state.isCompletedImgPerson,
        isCompletedImgVehicle: state.isCompletedImgVehicle,
        isCompletedInsurance: state.isCompletedInsurance,
        isCompletedLicense: state.isCompletedLicense,
        isCompletedRegisterVehicle: state.isCompletedRegisterVehicle);
    statusModel.isCompletedLicense = isCompleted;
    state = statusModel;
  }

  void setRegisterVehicle(bool isCompleted) {
    StatusInfoModel statusModel = StatusInfoModel(
        isCompletedEmail: state.isCompletedEmail,
        isCompletedEmergency: state.isCompletedEmergency,
        isCompletedID: state.isCompletedID,
        isCompletedImgPerson: state.isCompletedImgPerson,
        isCompletedImgVehicle: state.isCompletedImgVehicle,
        isCompletedInsurance: state.isCompletedInsurance,
        isCompletedLicense: state.isCompletedLicense,
        isCompletedRegisterVehicle: state.isCompletedRegisterVehicle);
    statusModel.isCompletedRegisterVehicle = isCompleted;
    state = statusModel;
  }
}

final statusProvider = StateNotifierProvider<StatusNotifier, StatusInfoModel>(
    (ref) => StatusNotifier());
