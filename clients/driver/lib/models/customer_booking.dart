import 'package:driver/models/driver_info_register.dart';
import 'package:driver/providers/customer_request.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DriverSubmit {
  final CustomerRequestDetails tripInfo;
  final DriverInfoRegisterModel driver;
  final List<PointLatLng> directions;
  final double rotate;

  DriverSubmit(
      {required this.tripInfo, required this.driver, required this.directions, required this.rotate});

  factory DriverSubmit.fromJson(Map<String, dynamic> json) {
    return DriverSubmit(
      tripInfo: CustomerRequestDetails.fromJson(json['trip_info']),
      driver: DriverInfoRegisterModel.fromJson(json['driver']),
      rotate: 0,
      directions: [],
    );
  }

  Map<String, dynamic> toJson() => {
        'trip_info': tripInfo.toJson(),
        'driver': driver.toJson(),
        'directions': directions.toString(),
        'rotate': rotate.toString(),
      };
}
