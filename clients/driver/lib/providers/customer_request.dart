import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/models/booking.dart';
import 'package:driver/models/customer.dart';
import 'package:driver/models/customer_request.dart';
import 'package:driver/models/direction_model.dart';
import 'package:driver/models/location.dart';
import 'package:driver/providers/current_location.dart';
import 'package:driver/providers/route_provider.dart';
import 'package:driver/providers/socket_provider.dart';
import 'package:driver/data/direction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerRequestDetails {
  final LocationPostion currentLocation;
  final CustomerRequest customer_infor;
  final String duration_time;
  final String duration_distance;
  final Directions direction;

  CustomerRequestDetails(
      {required this.customer_infor,
      required this.duration_distance,
      required this.duration_time,
      required this.direction,
      required this.currentLocation});

  bool hasValue() {
    return customer_infor.hasValue() &&
        duration_distance != "" &&
        duration_time != "";
  }

  factory CustomerRequestDetails.fromJson(Map<String, dynamic> json) {
    return CustomerRequestDetails(
      customer_infor: CustomerRequest.fromJson(json['customer_infor']),
      duration_distance: json['duration_distance'],
      duration_time: json['duration_time'],
      direction: Directions.fromJson(json['direction']),
      currentLocation: LocationPostion.fromJson(json['currentLocation']),
    );
  }

  Map<String, dynamic> toJson() => {
        'customer_infor': customer_infor.toJson(),
        'duration_distance': duration_distance,
        'duration_time': duration_time,
        'currentLocation': currentLocation.toJson(),
      };
}

class CustomerRequestNotifier extends StateNotifier<CustomerRequestDetails> {
  final SocketClient _socket;
  final RouteListNotifier _routeListNotifier;
  final LocationPostion currentLocation;

  CustomerRequestNotifier(
      this._socket, this.currentLocation, this._routeListNotifier)
      : super(CustomerRequestDetails(
            customer_infor: CustomerRequest(
                tripId: '',
                customerId: '',
                customer: Customer(
                  avatar: '',
                  default_payment_method: '',
                  firstname: '',
                  lastname: '',
                  phonenumber: '',
                  rank: '',
                ),
                distance: '',
                eta: '',
                origin: LocationAddress(description: '', lng: '', lat: ''),
                destination: LocationAddress(description: '', lng: '', lat: ''),
                price: '',
                couponId: '',
                serviceId: ''),
            direction: Directions(
              bounds: LatLngBounds(
                southwest: const LatLng(0, 0),
                northeast: const LatLng(0, 0),
              ),
              polylinePoints: [],
              totalDistance: '',
              totalDuration: '',
            ),
            currentLocation: LocationPostion(
              lat: 0,
              lng: 0,
            ),
            duration_distance: '',
            duration_time: '')) {
    if (_socket.connected()) {
      _socket.subscribe('demand-suggesting', (data) async {
        CustomerRequest customerReq =
            CustomerRequest.fromJson(data['tripInfo']);

        Directions? direct = await DirectionRepository(dio: Dio()).getDirection(
            origin: LatLng(currentLocation.lat, currentLocation.lng),
            destination: LatLng(double.parse(customerReq.origin.lat),
                double.parse(customerReq.origin.lng)));

        if (!mounted) return;

        _routeListNotifier.setRoute(direct!.routeDirectionList!);

        state = CustomerRequestDetails(
            direction: direct,
            customer_infor: customerReq,
            duration_distance: direct.totalDistance!,
            duration_time: direct.totalDuration!,
            currentLocation: LocationPostion(
              lat: currentLocation.lat,
              lng: currentLocation.lng,
            ));
      });
    }
  }

  Future<Directions?> acceptRequest() async {
    Directions? direct = await DirectionRepository(dio: Dio()).getDirection(
        origin: LatLng(double.parse(state.customer_infor.origin.lat),
            double.parse(state.customer_infor.origin.lng)),
        destination: LatLng(double.parse(state.customer_infor.destination.lat),
            double.parse(state.customer_infor.destination.lng)));

    if (!mounted) return direct;

    _routeListNotifier.setRoute(direct!.routeDirectionList!);

    state = CustomerRequestDetails(
        direction: direct,
        customer_infor: state.customer_infor,
        duration_distance: direct.totalDistance!,
        duration_time: direct.totalDuration!,
        currentLocation: LocationPostion(
          lat: currentLocation.lat,
          lng: currentLocation.lng,
        ));

    return direct;
  }

  void cancelRequest() {
    if (!mounted) return;

    state = CustomerRequestDetails(
        customer_infor: CustomerRequest(
            tripId: '',
            customerId: '',
            customer: Customer(
              avatar: '',
              default_payment_method: '',
              firstname: '',
              lastname: '',
              phonenumber: '',
              rank: '',
            ),
            distance: '',
            eta: '',
            origin: LocationAddress(description: '', lng: '', lat: ''),
            destination: LocationAddress(description: '', lng: '', lat: ''),
            price: '',
            couponId: '',
            serviceId: ''),
        direction: Directions(
          bounds: LatLngBounds(
            southwest: const LatLng(0, 0),
            northeast: const LatLng(0, 0),
          ),
          polylinePoints: [],
          totalDistance: '',
          totalDuration: '',
        ),
        duration_distance: '',
        duration_time: '',
        currentLocation: LocationPostion(lat: 0, lng: 0));
  }
}

final customerRequestProvider =
    StateNotifierProvider<CustomerRequestNotifier, CustomerRequestDetails>(
        (ref) {
  ref.watch(socketClientProvider);

  final Position currentLocation = ref.watch(currentLocationProvider);

  print(currentLocation.latitude);
  print(currentLocation.longitude);

  return CustomerRequestNotifier(
      ref.read(socketClientProvider.notifier),
      LocationPostion(
          lat: currentLocation.latitude, lng: currentLocation.longitude),
      ref.read(routeListProvider.notifier));
});
