import 'dart:convert';

import 'package:customer/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../functions/convertTimeFormat.dart';
import '../models/customer_model.dart';
import '../models/location_model.dart';
import '../models/route_model.dart';

class SocketClient extends StateNotifier<void> {
  static final SocketClient _socketClient = SocketClient._internal();

  static late Socket socket;

  SocketClient._internal() : super(()) {
    _createSocket();

    print('SocketClient created');
  }

  _createSocket() {
    print('socket');

    socket = io(
      'ws://192.168.1.4:5001',
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableReconnection()
          .build(),
    );
    socket.connect();
    emitInitSocket();
  }

  factory SocketClient() {
    return _socketClient;
  }

  void subscribe(String event, dynamic Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void emitInitSocket() {
    print('socket join');
    socket.emit('join-server', {
      "customerId": "khangdinh",
      "customer": {
        "firstname": "Khang",
        "lastname": "Dinh",
        "phonenumber": "0976975548",
        "avatar":
            "https://www.facebook.com/photo/?fbid=1504786969778047&set=pob.100007402751192"
      },
    });
  }

  void emitBookingCar(
      LocationModel depature, LocationModel arrival, RouteModel routeModel) {
    logger.d("BOOKING");
    logger.d(routeModel.toString());
    socket.emit('booking-trip', {
      "customerId": "khangdinh",
      "customer": {
        "rank": "golden",
        "default_payment_method": "cash",
        "firstname": "Khang",
        "lastname": "Dinh",
        "phonenumber": "0976975548",
        "avatar": "https://i.pinimg.com/originals/19/f3/4c/19f34c7f25d5a9f8dcd41b76d0e0636c.jpg"
      },
      "role": "customer",
      "distance": routeModel.distance,
      "eta": routeModel.time,
      "origin": {
        "lat": depature.postion!.latitude.toString(),
        "lng": depature.postion!.longitude.toString(),
        "description":
            '${depature.structuredFormatting!.mainText}, ${depature.structuredFormatting!.secondaryText}',
      },
      "destination": {
        "lat": arrival.postion!.latitude.toString(),
        "lng": arrival.postion!.longitude.toString(),
        "description":
            '${arrival.structuredFormatting!.mainText}, ${arrival.structuredFormatting!.secondaryText}',
      },
      "price": routeModel.price,
      "couponId": "",
      "serviceId": "KabRide",
    });
  }

  void emitLocateDriver(dynamic data) {
    socket.emit('locate-driver', data);
  }

  // void emitBookingCar(LatLng depature) {
  //   socket.emit(
  //       'coordinator',
  //       json.encode(
  //         {
  //           'id': 'khangdinh',
  //           'name': 'khangdinh',
  //           'position': {
  //             'coor': {'lat': depature.latitude, 'lng': depature.longitude},
  //             'rad': 0.75,
  //           },
  //           'role': 'customer',
  //         },
  //       ));
  // }

  // void emitBookingCar(LocationModel depature, LocationModel arrival,
  //     RouteModel routeModel, CustomerModel customerModel) {
  //   socket.emit(
  //     "booking-car",
  //     jsonEncode(
  //       {
  //         'user_information': {
  //           "avatar": customerModel.avatar,
  //           "name": customerModel.name,
  //           "email": customerModel.email,
  //           "phonenumber": customerModel.phonenumber,
  //           "dob": customerModel.dob,
  //           "home_address": customerModel.home_address,
  //           "type": customerModel.type,
  //           "default_payment_method": customerModel.default_payment_method,
  //           "rank": customerModel.rank,
  //         },
  //         'departure_information': {
  //           'address':
  //               '${depature.structuredFormatting!.mainText}, ${depature.structuredFormatting!.secondaryText}',
  //           'latitude': depature.postion!.latitude.toString(),
  //           'longitude': depature.postion!.longitude.toString(),
  //         },
  //         'arrival_information': {
  //           'address':
  //               '${arrival.structuredFormatting!.mainText}, ${arrival.structuredFormatting!.secondaryText}',
  //           'latitude': arrival.postion!.latitude.toString(),
  //           'longitude': arrival.postion!.longitude.toString(),
  //         },
  //         "service": routeModel.service,
  //         'price': routeModel.price,
  //         'distance': routeModel.distance,
  //         'time': convertTimeFormat(routeModel.time!),
  //         'coupon': routeModel.coupon
  //       },
  //     ),
  //   );
  // }

  void emitCancelBooing(LocationModel depature, LocationModel arrival,
      RouteModel routeModel, CustomerModel customerModel) {
    socket.emit(
      "customer-cancel",
      jsonEncode(
        {
          'user_information': {
            "avatar": customerModel.avatar,
            "name": customerModel.name,
            "email": customerModel.email,
            "phonenumber": customerModel.phonenumber,
            "dob": customerModel.dob,
            "home_address": customerModel.home_address,
            "type": customerModel.type,
            "default_payment_method": customerModel.default_payment_method,
            "rank": customerModel.rank,
          },
          'departure_information': {
            'address':
                '${depature.structuredFormatting!.mainText}, ${depature.structuredFormatting!.secondaryText}',
            'latitude': depature.postion!.latitude.toString(),
            'longitude': depature.postion!.longitude.toString(),
          },
          'arrival_information': {
            'address':
                '${arrival.structuredFormatting!.mainText}, ${arrival.structuredFormatting!.secondaryText}',
            'latitude': arrival.postion!.latitude.toString(),
            'longitude': arrival.postion!.longitude.toString(),
          },
          "service": routeModel.service,
          'price': routeModel.price,
          'distance': routeModel.distance,
          'time': convertTimeFormat(routeModel.time!),
          // 'coupon': routeModel.coupon
        },
      ),
    );
  }
}

final socketClientProvider =
    StateNotifierProvider<SocketClient, void>((ref) => SocketClient());
