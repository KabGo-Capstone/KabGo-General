import 'dart:io';

import 'package:driver/models/driving_license.dart';
import 'package:riverpod/riverpod.dart';

class DrivingLicenseNotifier extends StateNotifier<DrivingLicenseModel> {
  DrivingLicenseNotifier() : super(DrivingLicenseModel());

  void setDriverModel(DrivingLicenseModel value) async {
    state = value;
  }

  void setDrivingLicenseBefore(File img) {
    DrivingLicenseModel drivingLicenseModel = DrivingLicenseModel();
    drivingLicenseModel.imgDrivingLicenseBefore = img;
    state = drivingLicenseModel;
  }

  void setDrivingLicenseAfter(File img) {
    DrivingLicenseModel drivingLicenseModel = DrivingLicenseModel(
        imgDrivingLicenseBefore: state.imgDrivingLicenseBefore);
    drivingLicenseModel.imgDrivingLicenseAfter = img;
    state = drivingLicenseModel;
  }
}

final drivingLicenseProvider =
    StateNotifierProvider<DrivingLicenseNotifier, DrivingLicenseModel>(
        (ref) => DrivingLicenseNotifier());
