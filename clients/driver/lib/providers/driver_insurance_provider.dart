import 'dart:io';

import 'package:driver/models/driver_insurance_model.dart';
import 'package:riverpod/riverpod.dart';

class DriverInsuranceNotifier extends StateNotifier<DriverInsuranceModel> {
  DriverInsuranceNotifier() : super(DriverInsuranceModel());

  void setInsuranceModel(DriverInsuranceModel value) async {
    state = value;
  }

  void setDrivingLicenseFront(File img) {
    DriverInsuranceModel driverInsurance = DriverInsuranceModel(
      imgDriverInsuranceBack: state.imgDriverInsuranceBack,
    );
    driverInsurance.imgDriverInsuranceFront = img;
    state = driverInsurance;
  }

  void setDrivingLicenseBack(File img) {
    DriverInsuranceModel driverInsurance = DriverInsuranceModel(
        imgDriverInsuranceFront: state.imgDriverInsuranceFront);
    driverInsurance.imgDriverInsuranceBack = img;
    state = driverInsurance;
  }
}

final driverInsuranceProvider =
    StateNotifierProvider<DriverInsuranceNotifier, DriverInsuranceModel>(
        (ref) => DriverInsuranceNotifier());
