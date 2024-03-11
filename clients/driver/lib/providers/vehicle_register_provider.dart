import 'dart:io';

import 'package:driver/models/vehicle_register_model.dart';
import 'package:riverpod/riverpod.dart';

class VehicleRegisterNotifier extends StateNotifier<VehicleRegisterModel> {
  VehicleRegisterNotifier() : super(VehicleRegisterModel());

  void setDriverModel(VehicleRegisterModel value) async {
    state = value;
  }

  void setVehicleRegisterImageFront(File image) {
    VehicleRegisterModel vehicleRegisterModel = VehicleRegisterModel(
        vehicleRegisterBack: state.vehicleRegisterBack,
        vehicleRegisterFront: state.vehicleRegisterFront,
        identityVehicle: state.identityVehicle,
        nameVehicle: state.nameVehicle,
        brandVehicle: state.brandVehicle,
        fuelVehicle: state.fuelVehicle,
        colorVehicle: state.colorVehicle);
    vehicleRegisterModel.vehicleRegisterFront = image;
    state = vehicleRegisterModel;
  }

  void setVehicleRegisterImageBack(File image) {
    VehicleRegisterModel vehicleRegisterModel = VehicleRegisterModel(
        vehicleRegisterBack: state.vehicleRegisterBack,
        vehicleRegisterFront: state.vehicleRegisterFront,
        identityVehicle: state.identityVehicle,
        nameVehicle: state.nameVehicle,
        brandVehicle: state.brandVehicle,
        fuelVehicle: state.fuelVehicle,
        colorVehicle: state.colorVehicle);
    vehicleRegisterModel.vehicleRegisterBack = image;
    state = vehicleRegisterModel;
  }

  void setVehicleRegisterName(String name) {
    state.nameVehicle = name;
  }

  void setVehicleRegisterBrand(String brand) {
    state.brandVehicle = brand;
  }

  void setVehicleRegisterColor(String color) {
    state.colorVehicle = color;
  }

  void setVehicleRegisterIdentity(String id) {
    state.identityVehicle = id;
  }

  void setFuelVehicleRegister(String fuel) {
    state.fuelVehicle = fuel;
  }
}

final vehicleRegisterNotifier =
    StateNotifierProvider<VehicleRegisterNotifier, VehicleRegisterModel>(
        (ref) => VehicleRegisterNotifier());
