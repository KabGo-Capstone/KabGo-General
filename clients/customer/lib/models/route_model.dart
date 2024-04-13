// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'location_model.dart';

class RouteModel {
  LocationModel? departureLocation;
  LocationModel? arrivalLocation;
  String? distance;
  String? time;
  String service = '';
  String price = '';
  String coupon = '';
  String paymentMethod = 'Tiền mặt';

  RouteModel({
    this.departureLocation,
    this.arrivalLocation,
    this.distance,
    this.time,
  });

  @override
  String toString() {
    return 'RouteModel(departureLocation: $departureLocation, arrivalLocation: $arrivalLocation, distance: $distance, time: $time, service: $service, price: $price, coupon: $coupon, paymentMethod: $paymentMethod)';
  }
}
