import 'dart:io';

import 'package:driver/models/driver_model.dart';
import 'package:riverpod/riverpod.dart';

class DriverNotifier extends StateNotifier<DriverModel> {
  DriverNotifier() : super(DriverModel());

  void setDriverModel(DriverModel value) async {
    state = value;
  }

  void setIdImageBefore(File img) {
    DriverModel driverModel = DriverModel(
        date: state.date,
        fileIdImgAfter: state.fileIdImgAfter,
        personImage: state.personImage);
    driverModel.fileIdImgBefore = img;
    state = driverModel;
  }

  void setIdImageAfter(File img) {
    DriverModel driverModel = DriverModel(
        date: state.date,
        fileIdImgBefore: state.fileIdImgBefore,
        personImage: state.personImage);
    driverModel.fileIdImgAfter = img;
    state = driverModel;
  }

  void setPersonImage(File personImg) {
    DriverModel driverModel = DriverModel(
        date: state.date,
        fileIdImgBefore: state.fileIdImgBefore,
        fileIdImgAfter: state.fileIdImgAfter);
    driverModel.personImage = personImg;
    state = driverModel;
  }

  void setDate(String date) {
    state.date = date;
  }
}

final driverProvider = StateNotifierProvider<DriverNotifier, DriverModel>(
    (ref) => DriverNotifier());
