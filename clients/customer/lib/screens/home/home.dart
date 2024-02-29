import 'dart:io';
import 'package:customer/data/data.dart';
import 'package:customer/functions/determinePosition.dart';
import 'package:customer/functions/setAddressByPosition.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/currentLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/screens/home/animated_text.dart';
import 'package:customer/screens/home/bottom_navigation.dart';
import 'package:customer/screens/search/search.dart';
import 'package:customer/widgets/favorite_location_item.dart';
import 'package:customer/widgets/recently_arrival_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    initLocation();
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

  void initLocation() async {
    LatLng latLng = await determinePosition();
    LocationModel currentLocationModel = await setAddressByPosition(latLng);
    currentLocationModel.structuredFormatting!.formatSecondaryText();
    ref
        .read(departureLocationProvider.notifier)
        .setDepartureLocation(currentLocationModel);
    ref.read(currentLocationProvider.notifier).setCurrentLocation(latLng);
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 208, 186),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Container(
                    height: 165,
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Xin chào,',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 232, 223),
                                  minimumSize: Size.zero, // Set this
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 9,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // ref
                                  //     .read(mapProvider.notifier)
                                  //     .setMapAction('LOCATION_PICKER');
                                  // ref.read(stepProvider.notifier).setStep('location_picker');
                                  // ref
                                  //     .read(pickerLocationProvider.notifier)
                                  //     .setPickerLocation(ref.read(departureLocationProvider));
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.mapLocationDot,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                label: const Text(
                                  'Bản đồ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Đinh Nguyễn Duy Khang',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            Image.asset(
                              'lib/assets/images/home_page_background.png',
                              height: 100,
                            ),
                          ],
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
                        height: 20,
                      ),
                      Column(
                        children: [
                          ...recentlyArrivalData.take(3).map(
                                (e) => InkWell(
                                  onTap: () {
                                    // ref
                                    //     .read(arrivalLocationProvider.notifier)
                                    //     .setArrivalLocation(e);
                                    // chooseArrival();
                                  },
                                  child: RecentlyArrivalItem(
                                    padding: 16,
                                    data: e,
                                  ),
                                ),
                              )
                        ],
                      ),
                      if (recentlyArrivalData.isNotEmpty)
                        const SizedBox(
                          height: 28,
                        ),
                      Text(
                        'Các địa điểm yêu thích',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 100,
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
                                  : Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 56,
                                          width: 56,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 245, 239),
                                            shape: BoxShape.circle,
                                          ),
                                          child: favoriteLocationData[index]
                                              ['icon'] as Widget,
                                        ),
                                      ],
                                    );
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: Platform.isIOS ? 200 : 160,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const Search(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0, 1);
                            const end = Offset(0, 0);

                            final tween = Tween(begin: begin, end: end);
                            return SlideTransition(
                              position: tween.animate(animation),
                              child: child,
                            );
                          },
                        ));
                  },
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        Container(
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.solidCircleDot,
                            size: 16,
                            color: Color(0xffFF5858),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        const AnimatedText()
                      ],
                    ),
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
