// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class VehicleRegisterModel {
  File? vehicleRegisterFront;
  File? vehicleRegisterBack;
  String? nameVehicle;
  String? brandVehicle;
  String? identityVehicle;
  String? colorVehicle;
  String? fuelVehicle;

  VehicleRegisterModel(
      {this.vehicleRegisterFront,
      this.vehicleRegisterBack,
      this.nameVehicle,
      this.brandVehicle,
      this.identityVehicle,
      this.colorVehicle,
      this.fuelVehicle});
}
