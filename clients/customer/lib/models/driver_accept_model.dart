// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

List<PointLatLng> parseStringToPointList(String s) {
  final pattern = RegExp(r'lat:\s*(-?\d+\.\d+)\s*/\s*longitude:\s*(-?\d+\.\d+)');
  final matches = pattern.allMatches(s);
  final points = <PointLatLng>[];

  for (var match in matches) {
    final lat = double.parse(match.group(1)!);
    final lon = double.parse(match.group(2)!);
    points.add(PointLatLng(lat, lon));
  }

  return points;
}

List<PointLatLng> fromString(String directions) {
  directions = directions.replaceAll('[', '').replaceAll(']', '');

  List<PointLatLng> points = parseStringToPointList(directions);

  return points;
}

class DriverAcceptInfo {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String avatar;
  final String serviceName;

  DriverAcceptInfo({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.serviceName,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
    };
  }

  factory DriverAcceptInfo.fromMap(Map<String, dynamic> map) {
    return DriverAcceptInfo(
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      serviceName: map['serviceName'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverAcceptInfo.fromJson(String source) =>
      DriverAcceptInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DriverAcceptedModel {
  String? driverId;
  DriverAcceptInfo? driver;
  double rotate;
  List<PointLatLng> directions;

  DriverAcceptedModel({
    this.driverId,
    this.driver,
    this.rotate = 0,
    this.directions = const [],
  });

  DriverAcceptedModel copyWith({
    String? driverId,
    DriverAcceptInfo? driver,
  }) {
    return DriverAcceptedModel(
      driverId: driverId ?? this.driverId,
      driver: driver ?? this.driver,
      rotate: rotate,
      directions: directions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'driverId': driverId,
      'driver': driver,
      'rotate': rotate,
      'directions': directions,
    };
  }

  factory DriverAcceptedModel.fromMap(Map<String, dynamic> map) {
    return DriverAcceptedModel(
      driverId: map['driverId'] as String,
      driver: DriverAcceptInfo.fromMap(map['driver'] as Map<String, dynamic>),
      rotate: double.parse(map['rotate']),
      directions: (fromString(map['directions']))
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverAcceptedModel.fromJson(String source) =>
      DriverAcceptedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DriverAcceptedModel(driverId: $driverId, driver: $driver, rotate: $rotate, direction: $directions)';
  }

  @override
  bool operator ==(covariant DriverAcceptedModel other) {
    if (identical(this, other)) return true;

    return other.driverId == driverId && other.driver == driver && other.directions == directions && other.rotate == rotate;
  }

  @override
  int get hashCode {
    return driverId.hashCode ^ driver.hashCode ^ directions.hashCode ^ rotate.hashCode;
  }
}
