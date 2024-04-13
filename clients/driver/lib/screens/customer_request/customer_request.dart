import 'dart:convert';

import 'package:driver/constants/payment_methods.dart';
import 'package:driver/constants/ranks.dart';
import 'package:driver/models/customer_booking.dart';
import 'package:driver/models/driver.dart';
import 'package:driver/providers/current_location.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/socket_provider.dart';
import 'package:driver/screens/customer_request/customer_request_accept.dart';
import 'package:driver/screens/home_dashboard/home_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:driver/models/location.dart';
import 'package:driver/models/vehicle.dart';
import 'package:driver/providers/customer_request.dart';
import 'package:driver/providers/driver_details_provider.dart';
import 'package:driver/providers/request_status.dart';
import 'package:driver/screens/customer_request/styles.dart';

class CustomerRequest extends ConsumerStatefulWidget {
  const CustomerRequest({super.key});

  static String name = 'CustomerRequest';
  static String path = '/customer/request';

  @override
  ConsumerState<CustomerRequest> createState() => _CustomerRequestState();
}

class _CustomerRequestState extends ConsumerState<CustomerRequest> {
  @override
  Widget build(BuildContext context) {
    final socketManager = ref.read(socketClientProvider.notifier);
    final currentLocation =
        ref.read(currentLocationProvider.notifier).currentLocation();

    final driverDetails = ref.read(driverDetailsProvider);

    final customerRequestNotifier = ref.read(customerRequestProvider.notifier);
    final requestStatusNotifier = ref.read(requestStatusProvider.notifier);

    final customerRequest = ref.watch(customerRequestProvider);

    print(customerRequest.customer_infor.customer.avatar);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: customerRequest.customer_infor.customer.avatar.isEmpty
                    ? const Image(
                        image: AssetImage("assets/test/avatar.png"),
                        width: 60,
                        height: 60,
                      )
                    : Image.network(
                        customerRequest.customer_infor.customer.avatar,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 230,
                            child: Text(
                                customerRequest
                                        .customer_infor.customer.firstname +
                                    ' ' +
                                    customerRequest
                                        .customer_infor.customer.lastname,
                                style: ThemeText.customerName,
                                overflow: TextOverflow.ellipsis)),
                        Row(
                          children: <Widget>[
                            // Image(
                            //     image: AssetImage(
                            //         'assets/icons/${customerRequest.customer.rankType}.png'),
                            //     width: 20),
                            if (customerRequest.customer_infor.customer.rank
                                    .toLowerCase() ==
                                'đồng')
                              const Image(
                                  image: AssetImage('assets/icons/bronze.png'),
                                  width: 20),
                            if (customerRequest.customer_infor.customer.rank
                                    .toLowerCase() ==
                                'bạc')
                              const Image(
                                  image: AssetImage('assets/icons/silver.png'),
                                  width: 20),
                            if (customerRequest.customer_infor.customer.rank
                                    .toLowerCase() ==
                                'golden')
                              const Image(
                                  image: AssetImage('assets/icons/gold.png'),
                                  width: 20),
                            if (customerRequest.customer_infor.customer.rank
                                    .toLowerCase() ==
                                'kim cương')
                              const Image(
                                  image: AssetImage('assets/icons/diamon.png'),
                                  width: 20),
                            const SizedBox(width: 10),
                            Text(
                                'Hạng ${RANKINGS[customerRequest.customer_infor.customer.rank.toLowerCase()]}',
                                style: ThemeText.ranking),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(FontAwesomeIcons.solidCreditCard,
                                size: 15, color: Color(0xFFF86C1D)),
                            const SizedBox(width: 6),
                            Text(
                                PAYMENT_METHODS[customerRequest.customer_infor
                                    .customer.default_payment_method] ?? '',
                                style: ThemeText.bookingDetails),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: <Widget>[
                            const Icon(FontAwesomeIcons.taxi,
                                size: 15, color: Color(0xFFF86C1D)),
                            const SizedBox(width: 6),
                            Text(customerRequest.customer_infor.serviceId,
                                style: ThemeText.bookingDetails),
                          ],
                        ),
                        // if (customerRequest.booking.promotion) const Text('Khuyến mãi', style: ThemeText.bookingDetails),
                        // if (!customerRequest.customer.promotion) const Spacer(),
                        const Spacer(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(FontAwesomeIcons.mapPin,
                      size: 23, color: Color(0xFFF86C1D)),
                  const SizedBox(width: 6),
                  Text('Cách bạn ${customerRequest.duration_distance}',
                      style: ThemeText.locationDurationDetails),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(FontAwesomeIcons.locationArrow,
                      size: 23, color: Color(0xFFF86C1D)),
                  const SizedBox(width: 6),
                  Text('Lộ trình ${customerRequest.customer_infor.distance}',
                      style: ThemeText.locationDurationDetails),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(FontAwesomeIcons.solidClock,
                      size: 19, color: Color(0xFFF86C1D)),
                  const SizedBox(width: 8),
                  Text(customerRequest.customer_infor.eta,
                      style: ThemeText.locationDurationDetails),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Thông tin hành trình', style: ThemeText.headingTitle),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Image(
                        image: AssetImage('assets/icons/locations.png'),
                        width: 36),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          border: Border.all(
                            color: const Color(0xFFF2F2F2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width - 88,
                        child: Text(
                          customerRequest.customer_infor.origin.description,
                          style: ThemeText.locationDetails,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          border: Border.all(
                            color: const Color(0xFFF2F2F2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width - 88,
                        child: Text(
                          customerRequest
                              .customer_infor.destination.description,
                          style: ThemeText.locationDetails,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(children: <Widget>[
            // Expanded(
            //     child: ElevatedButton(
            //   onPressed: () {
            //     requestStatusNotifier.cancelRequest();
            //     customerRequestNotifier.cancelRequest();

            //     context.go(HomeDashboard.path);
            //   },
            //   style: ThemeButton.cancelButton,
            //   child: const Text('TỪ CHỐI', style: ThemeText.cancelButtonText),
            // )),
            ElevatedButton(
                onPressed: () {
                  requestStatusNotifier.cancelRequest();
                  customerRequestNotifier.cancelRequest();

                  context.go(HomeDashboard.path);
                },
                style: ThemeButton.cancelButton,
                child: const Center(
                  child: Icon(FontAwesomeIcons.xmark, color: Color(0xFFF42525)),
                )),
            const SizedBox(width: 16),
            Expanded(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        requestStatusNotifier.acceptRequest();
                        context.go(CustomerRequestAccept.path);
                      },
                      style: ThemeButton.acceptButton,
                      child: const Text('CHẤP NHẬN',
                          style: ThemeText.acceptButtonText),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    child: Builder(builder: (context) {
                      return CircularCountDownTimer(
                        width: 24,
                        height: 24,
                        duration: 10,
                        initialDuration: 0,
                        ringColor: const Color.fromRGBO(255, 255, 255, .8),
                        fillColor: const Color.fromRGBO(94, 169, 68, .7),
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        strokeWidth: 10.0,
                        strokeCap: StrokeCap.square,
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFF86C1D),
                          fontWeight: FontWeight.bold,
                        ),
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        isReverseAnimation: false,
                        autoStart: true,
                        onComplete: () {
                          requestStatusNotifier.cancelRequest();
                          customerRequestNotifier.cancelRequest();
                          context.go(HomeDashboard.path);
                        },
                        timeFormatterFunction:
                            (defaultFormatterFunction, duration) {
                          if (duration.inSeconds == 0) {
                            return '0';
                          } else {
                            return Function.apply(
                                defaultFormatterFunction, [duration]);
                          }
                        },
                      );
                    }),
                  )
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }
}
