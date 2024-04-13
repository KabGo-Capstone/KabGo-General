// ignore_for_file: non_constant_identifier_names

import 'package:driver/models/booking.dart';
import 'package:driver/models/customer.dart';

class CustomerRequest {
  String tripId;
  String customerId;
  Customer customer;
  String distance;
  String eta;
  LocationAddress origin;
  LocationAddress destination;
  String price;
  String couponId;
  String serviceId;
  String? Etag;
  String? revision;

  CustomerRequest({
    required this.tripId,
    required this.customerId,
    required this.customer,
    required this.distance,
    required this.eta,
    required this.origin,
    required this.destination,
    required this.price,
    required this.couponId,
    required this.serviceId, this.Etag = '', this.revision = '',
  });

  bool hasValue() {
    return customerId != "" &&
        customer.hasValue() &&
        distance != "" &&
        eta != "" &&
        origin.hasValue() &&
        destination.hasValue() &&
        price != "" &&
        serviceId != "";
  }

  factory CustomerRequest.fromJson(Map<String, dynamic> json) {
    return CustomerRequest(
      tripId: json['tripId'],
      customerId: json['customerId'],
      customer: Customer.fromJson(json['customer']),
      distance: json['distance'],
      eta: json['eta'],
      origin: LocationAddress.fromJson(json['origin']),
      destination: LocationAddress.fromJson(json['destination']),
      price: json['price'],
      couponId: json['couponId'] ?? '',
      serviceId: json['serviceId'],
      Etag: json['Etag'],
      revision: json['revision'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tripId': tripId,
        'customerId': customerId,
        'customer': customer.toJson(),
        'distance': distance,
        'eta': eta,
        'origin': origin.toJson(),
        'destination': destination.toJson(),
        'price': price,
        'couponId': couponId ?? '',
        'serviceId': serviceId,
        'Etag': Etag,
        'revision': revision,
      };
}
