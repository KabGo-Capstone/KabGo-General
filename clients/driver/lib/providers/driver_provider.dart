import 'dart:io';

import 'package:driver/models/driver_model.dart';
import 'package:riverpod/riverpod.dart';

class DriverNotifier extends StateNotifier<DriverModel> {
  DriverNotifier() : super(DriverModel());

  void setDriverModel(DriverModel value) async {
    state = value;
  }

  void setImage(File img) {
    DriverModel driverModel = DriverModel(date: state.date);
    driverModel.file = img;
    state = driverModel;
  }

  void setPersonImage(File personImg) {
    DriverModel driverModel = DriverModel(date: state.date, file: state.file);
    driverModel.personImage = personImg;
    state = driverModel;
  }

  void setDate(String date) {
    state.date = date;
  }
}

final driverProvider = StateNotifierProvider<DriverNotifier, DriverModel>(
    (ref) => DriverNotifier());
