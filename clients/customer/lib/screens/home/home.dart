import 'dart:convert';
import 'dart:io';

import 'package:customer/data/data.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/home/animated_text.dart';
import 'package:customer/screens/home/bottom_navigation.dart';
import 'package:customer/utils/Google_Api_Key.dart';
import 'package:customer/widgets/favorite_location_item.dart';
import 'package:customer/widgets/recently_arrival_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  List<LocationModel> bookingHistoryList = [];

  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  double heightDevice = Platform.isIOS ? 90 : 66;

  void bookingHistory() async {
    // final authState = ref.read(authProvider);
    // var dio = Dio();
    // var response = await dio.request(
    //   'http://$ip:4100/v1/customer-auth/get-booking-history',
    //   data: json.encode({
    //     'email': authState.value!.email,
    //   }),
    //   options: Options(
    //     method: 'POST',
    //   ),
    // );

    // if (response.statusCode == 200) {
    //   bookingHistoryList = [];
    //   for (var entry in response.data!['history']) {
    //     int firstCommaIndex = entry['destination']['address'].indexOf(',');
    //     StructuredFormatting structuredFormatting = StructuredFormatting(
    //         mainText: entry['destination']['address']
    //             .substring(0, firstCommaIndex)
    //             .trim(),
    //         secondaryText: entry['destination']['address']
    //             .substring(firstCommaIndex + 1)
    //             .trim());
    //     structuredFormatting.formatSecondaryText();
    //     LocationModel locationModel = LocationModel(
    //         placeId: '',
    //         structuredFormatting: structuredFormatting,
    //         postion: LatLng(entry['destination']['latitude'],
    //             entry['destination']['longitude']));
    //     bookingHistoryList.add(locationModel);
    //   }
    //   setState(() {});
    // } else {
    //   print(response.statusMessage);
    // }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // bookingHistory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  _scrollListener() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      if (scrollToBottom) {
        setState(() {
          scrollToBottom = false;
        });
      }
    } else if (direction == ScrollDirection.reverse) {
      if (!scrollToBottom) {
        setState(() {
          scrollToBottom = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('===========> HOME_PAGE BUILD');

    void chooseArrival() {
      // ref.read(stepProvider.notifier).setStep('choose_departure');
      // ref
      //     .read(mapProvider.notifier)
      //     .setMapAction('GET_CURRENT_DEPARTURE_LOCATION');

      // Navigator.pop(context);
    }

    String arrivalValue = ref.read(arrivalLocationProvider).placeId != null
        ? ref.read(arrivalLocationProvider).structuredFormatting!.mainText!
        : '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 191, 161),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.only(left: 15, top: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Xin chào,',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            Text(
                              'Đinh Nguyễn Duy Khang',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Image.asset(
                          'lib/assets/images/home_page_background.png',
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Các địa điểm yêu thích',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: favoriteLocationData.length,
                            itemBuilder: (context, index) {
                              return index != favoriteLocationData.length - 1
                                  ? InkWell(
                                      onTap: () {
                                        ref
                                            .read(arrivalLocationProvider
                                                .notifier)
                                            .setArrivalLocation(
                                                favoriteLocationData[index]
                                                        ['location']
                                                    as LocationModel);
                                        chooseArrival();
                                      },
                                      child: FavoriteLocationItem(
                                        data: favoriteLocationData[index],
                                      ),
                                    )
                                  : Container(
                                      // height: 70,
                                      width: 82,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 249, 249, 249),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color.fromARGB(
                                                255, 242, 242, 242)),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: favoriteLocationData[index]
                                            ['icon'] as Widget,
                                      ),
                                    );
                            }),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Các điểm đến trước đây',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ]),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          ...recentlyArrivalData.map(
                            (e) => InkWell(
                              onTap: () {
                                // ref
                                //     .read(arrivalLocationProvider.notifier)
                                //     .setArrivalLocation(e);
                                // chooseArrival();
                              },
                              child: RecentlyArrivalItem(
                                data: e,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: Platform.isIOS ? 186 : 152,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 56,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 73, 73, 73)
                            .withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/assets/images/arrival_icon.png',
                        width: 36,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const AnimatedText()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: scrollToBottom ? 0 : heightDevice,
        child: const Wrap(children: [BottomNavigation()]),
      ),
    );
  }
}
