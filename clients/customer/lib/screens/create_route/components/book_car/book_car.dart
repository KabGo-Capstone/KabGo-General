import 'package:customer/data/data.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/models/route_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/routeProvider.dart';
import 'package:customer/providers/socketProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/widgets/bottom_button.dart';
import 'package:customer/widgets/car_card_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'choose_payment_method.dart';
import 'discount_page.dart';

class BookCar extends ConsumerStatefulWidget {
  const BookCar({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends ConsumerState<BookCar> {
  String? hour;
  String? minute;
  dynamic listCoupon;

  dynamic chosenItem = listCarCard1.first;
  void setChoseItem(dynamic item, StateSetter stateSetter) {
    stateSetter(() {
      chosenItem = item;
    });
  }

  // Future<void> bookCar() async {
  //   SocketClient socketClient = ref.read(socketClientProvider.notifier);
  //   socketClient.emitBookingCar(ref.read(departureLocationProvider).postion!);
  //   // LocationModel departure = ref.read(departureLocationProvider);
  //   // LocationModel arrival = ref.read(arrivalLocationProvider);
  //   // RouteModel routeModel = ref.read(routeProvider);
  //   // CustomerModel customerModel = ref.read(customerProvider);
  //   // socketClient.emitBookingCar(departure, arrival, routeModel, customerModel);
  //   ref.read(stepProvider.notifier).setStep('find_driver');
  //   ref.read(mapProvider.notifier).setMapAction('FIND_DRIVER');
  //   // ref.read(couponProvider.notifier).setCoupon(0);
  // }

  // var dio = Dio();
  // var response = await dio.request(
  //   'http://192.168.2.165:4600/user/booking-car',
  //   data: json.encode({
  //     "data": {"message": "Dat xe thanh cong!"}
  //   }),
  //   options: Options(
  //     method: 'POST',
  //   ),
  // );

  // if (response.statusCode == 200) {
  //   print(json.encode(response.data));
  // } else {
  //   print(response.statusMessage);
  // }

  // IO.Socket socket = IO.io('http://192.168.2.165:4600');
  // socket.onConnect((_) {
  //   print('connect');
  //   socket.emit('msg', 'test');
  // });
  // socket.on('event', (data) => print(data));
  // socket.onDisconnect((_) => print('disconnect'));
  // socket.on('fromServer', (_) => print(_));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RouteModel routeModal = ref.watch(routeProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
            child: StatefulBuilder(
              builder: (context, setChooseItemState) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...listCarCard1.map(
                    (e) => InkWell(
                      onTap: () {
                        setChoseItem(
                            e, setChooseItemState);
                      },
                      child: CarCardItem(
                        isChosen: chosenItem == e,
                        data: e,
                        distance: routeModal.distance!,
                      ),
                    ),
                  ),
                  // ...listCarCard2.map(
                  //   (e) => InkWell(
                  //     onTap: () {
                  //       setChoseItem(
                  //           e, setChooseItemState);
                  //     },
                  //     child: CarCardItem(
                  //       isChosen: chosenItem == e,
                  //       data: e,
                  //       distance: routeModal.distance!,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
