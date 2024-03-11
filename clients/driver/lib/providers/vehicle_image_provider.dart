import 'dart:io';

import 'package:driver/models/vehicle_image_model.dart';
import 'package:riverpod/riverpod.dart';

class VehicleImageNotifier extends StateNotifier<VehileImageModel> {
  VehicleImageNotifier() : super(VehileImageModel());

  void setDriverModel(VehileImageModel value) async {
    state = value;
  }

  void setVehicleFront(File img) {
    VehileImageModel vehicleImageModel = VehileImageModel(
        vehicleImageBack: state.vehicleImageBack,
        vehicleImageLeft: state.vehicleImageLeft,
        vehicleImageFront: state.vehicleImageFront,
        vehicleImageRight: state.vehicleImageRight);
    vehicleImageModel.vehicleImageFront = img;
    state = vehicleImageModel;
  }

  void setVehicleBack(File img) {
    VehileImageModel vehicleImageModel = VehileImageModel(
        vehicleImageBack: state.vehicleImageBack,
        vehicleImageLeft: state.vehicleImageLeft,
        vehicleImageFront: state.vehicleImageFront,
        vehicleImageRight: state.vehicleImageRight);
    vehicleImageModel.vehicleImageBack = img;
    state = vehicleImageModel;
  }

  void setVehicleRight(File img) {
    VehileImageModel vehicleImageModel = VehileImageModel(
        vehicleImageBack: state.vehicleImageBack,
        vehicleImageLeft: state.vehicleImageLeft,
        vehicleImageFront: state.vehicleImageFront,
        vehicleImageRight: state.vehicleImageRight);
    vehicleImageModel.vehicleImageRight = img;
    state = vehicleImageModel;
  }

  void setVehicleLeft(File img) {
    VehileImageModel vehicleImageModel = VehileImageModel(
        vehicleImageBack: state.vehicleImageBack,
        vehicleImageLeft: state.vehicleImageLeft,
        vehicleImageFront: state.vehicleImageFront,
        vehicleImageRight: state.vehicleImageRight);
    vehicleImageModel.vehicleImageLeft = img;
    state = vehicleImageModel;
  }
}

final vehicleImageProvider =
    StateNotifierProvider<VehicleImageNotifier, VehileImageModel>(
        (ref) => VehicleImageNotifier());
