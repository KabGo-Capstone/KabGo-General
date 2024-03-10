import 'dart:io';
import 'package:customer/data/data.dart';
import 'package:customer/functions/determinePosition.dart';
import 'package:customer/functions/setAddressByPosition.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/currentLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/screens/home/components/bottom_navigation.dart';
import 'package:customer/screens/home/components/favorite_location.dart';
import 'package:customer/screens/home/components/find_arrival_button.dart';
import 'package:customer/screens/home/components/hot_location.dart';
import 'package:customer/screens/home/components/map_picker.dart';
import 'package:customer/screens/home/components/more_way_to_move.dart';
import 'package:customer/screens/home/components/recently_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    ref.read(currentLocationProvider.notifier).setCurrentLocation(currentLocationModel);
    // ref
    //     .read(departureLocationProvider.notifier)
    //     .setDepartureLocation(currentLocationModel);
        // ref
        // .read(arrivalLocationProvider.notifier)
        // .setArrivalLocation(currentLocationModel);
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
                const MapPicker(),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const RecentlyLocation(),
                      if (recentlyArrivalData.isNotEmpty)
                        const SizedBox(height: 28),
                      const HotLocation(),
                      const SizedBox(height: 28),
                      const MoreWayToMove(),
                      const SizedBox(height: 28),
                      const FavoriteLocation(),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: Platform.isIOS ? 200 : 165,
              width: MediaQuery.of(context).size.width,
              child: const FindArrivalButton(),
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
