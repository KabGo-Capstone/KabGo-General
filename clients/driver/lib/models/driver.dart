// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:driver/models/location.dart';
import 'package:driver/models/vehicle.dart';

class DriverInfo {
  final String firstname;
  final String lastname;
  final String phonenumber;
  final String avatar;

  DriverInfo({
    required this.firstname,
    required this.lastname,
    required this.phonenumber,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'phonenumber': phonenumber,
      'avatar': avatar,
    };
  }

  factory DriverInfo.fromMap(Map<String, dynamic> map) {
    return DriverInfo(
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      phonenumber: map['phonenumber'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverInfo.fromJson(String source) =>
      DriverInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Driver {
  String driverId;
  DriverInfo driver;
  String service;
  Vehicle vehicle;
  LocationPostion position;
  String status;

  Driver({
    required this.driverId,
    required this.driver,
    required this.service,
    required this.vehicle,
    required this.position,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'driverId': driverId,
      'driver': driver.toMap(),
      'service': service,
      'vehicle': vehicle.toMap(),
      'position': position.toJson(),
      'status': status,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      driverId: map['driverId'] as String,
      driver: DriverInfo.fromMap(map['driver'] as Map<String, dynamic>),
      service: map['service'] as String,
      vehicle: Vehicle.fromMap(map['vehicle'] as Map<String, dynamic>),
      position:
          LocationPostion.fromJson(map['position'] as Map<String, dynamic>),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) =>
      Driver.fromMap(json.decode(source) as Map<String, dynamic>);
}
