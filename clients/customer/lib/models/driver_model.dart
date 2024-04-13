// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

class DriverModel {
  String? driverId;
  DriverInfo? driver;
  String? service;
  dynamic vehicle;
  dynamic position;
  String? status;

  DriverModel({
     this.driverId,
     this.driver,
    this.service,
    this.vehicle,
    this.position,
    this.status,
  });

  DriverModel copyWith({
    String? driverId,
    DriverInfo? driver,
    String? service,
    dynamic vehicle,
    dynamic position,
    String? status,
  }) {
    return DriverModel(
      driverId: driverId ?? this.driverId,
      driver: driver ?? this.driver,
      service: service ?? this.service,
      vehicle: vehicle ?? this.vehicle,
      position: position ?? this.position,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'driverId': driverId,
      'driver': driver,
      'service': service,
      'vehicle': vehicle,
      'position': position,
      'status': status,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      driverId: map['driverId'] as String,
      driver: DriverInfo.fromMap(map['driver'] as Map<String, dynamic>),
      service: map['service'] as String,
      vehicle: map['vehicle'] as dynamic,
      position: map['position'] as dynamic,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) =>
      DriverModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DriverModel(driverId: $driverId, driver: $driver, service: $service, vehicle: $vehicle, position: $position, status: $status)';
  }

  @override
  bool operator ==(covariant DriverModel other) {
    if (identical(this, other)) return true;

    return other.driverId == driverId &&
        other.driver == driver &&
        other.service == service &&
        other.vehicle == vehicle &&
        other.position == position &&
        other.status == status;
  }

  @override
  int get hashCode {
    return driverId.hashCode ^
        driver.hashCode ^
        service.hashCode ^
        vehicle.hashCode ^
        position.hashCode ^
        status.hashCode;
  }
}
