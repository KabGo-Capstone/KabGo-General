import 'dart:convert';

import 'package:customer/functions/getBytesFromAsset.dart';
import 'package:customer/providers/coupon_provider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../functions/determinePosition.dart';
import '../../../functions/networkUtility.dart';
import '../../../functions/setAddressByPosition.dart';
import '../../../models/customer_model.dart';
import '../../../models/driver_model.dart';
import '../../../models/location_model.dart';
import '../../../models/route_model.dart';
import '../../../providers/arrivalLocationProvider.dart';
import '../../../providers/currentLocationProvider.dart';
import '../../../providers/departureLocationProvider.dart';
import '../../../providers/locationPickerInMap.dart';
import '../../../providers/routeProvider.dart';
import '../../../providers/stepProvider.dart';
import '../../../utils/Google_Api_Key.dart';

class MyMap extends ConsumerStatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends ConsumerState<MyMap> {
  late GoogleMapController googleMapController;
  CameraPosition? cameraPosition;
  String mapTheme = '';
  Set<Marker> markers = {};
  Set<Marker> _markers = {};
  List<LatLng> polylineCoordinates = [];
  LatLng? currentLocation;
  Set<Polyline> polylineList = {};
  BitmapDescriptor? bitmapDescriptor;

  double distance = 0;
  double travelTime = 0;

  LatLng? departureLocation;
  LatLng? arrivalLocation;
  double mapPaddingTop = 25;
  double mapPaddingLeft = 0;
  double mapPaddingBottom = 180;
  double mapPaddingRight = 0;
  double padding = 100;
  dynamic parsedValue;
  double zoom = 16.5;
  bool isDrawRoute = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('lib/assets/jsons/map.json')
        .then((value) => mapTheme = value);
  }

  void getArrivalLocation() async {
    LocationModel locationModel = ref.read(arrivalLocationProvider);
    if (locationModel.placeId != null) {
      if (locationModel.postion == null) {
        arrivalLocation = await locationModel.getLocation();
      } else {
        arrivalLocation = locationModel.postion;
      }
    } else {
      LatLng latLng = await determinePosition();
      LocationModel currentLocationModel = await setAddressByPosition(latLng);
      arrivalLocation = latLng;
      ref
          .read(arrivalLocationProvider.notifier)
          .setArrivalLocation(currentLocationModel);
    }

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(arrivalLocation!.latitude, arrivalLocation!.longitude),
            zoom: 16.5),
      ),
    );
    setState(() {});
  }

  void getDepartureLocation() async {
    LocationModel locationModel = ref.read(departureLocationProvider);
    if (locationModel.placeId != null) {
      if (locationModel.postion == null) {
        departureLocation = await locationModel.getLocation();
      } else {
        departureLocation = locationModel.postion;
      }
    } else {
      LatLng latLng = await determinePosition();
      LocationModel currentLocationModel = await setAddressByPosition(latLng);
      departureLocation = latLng;
      ref
          .read(departureLocationProvider.notifier)
          .setDepartureLocation(currentLocationModel);
    }

    googleMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                departureLocation!.latitude, departureLocation!.longitude),
            zoom: 16.5),
      ),
    );
    setState(() {});
  }

  void getNewCurrentLocation() async {
    currentLocation = await determinePosition();
    LocationModel currentLocationModel =
        await setAddressByPosition(currentLocation!);
    currentLocationModel.structuredFormatting!.formatSecondaryText();
    ref
        .read(currentLocationProvider.notifier)
        .setCurrentLocation(currentLocationModel);

    // ignore: collection_methods_unrelated_type
    // markers.remove(const MarkerId('currentLocation'));
    // markers.add(Marker(
    //   anchor: const Offset(0.5, 0.5),
    //   markerId: const MarkerId('currentLocation'),
    //   position: currentLocation!,
    //   icon: BitmapDescriptor.fromBytes(
    //       await getBytesFromAsset('lib/assets/images/my_location.png', 250)),
    // ));
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation!, zoom: 16.5),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('===========> MY_MAP BUILD');

    return Consumer(
      builder: (context, ref, child) {
        ref.listen(mapProvider, (previous, next) {
          if (next == 'get_current_location') {
            getNewCurrentLocation();
          } else if (next == 'arrival_location_picker') {
            getArrivalLocation();
          } else if (next == 'departure_location_picker') {
            getDepartureLocation();
          } else if (next == 'GET_CURRENT_DEPARTURE_LOCATION') {
          } else if (next == 'GET_NEW_DEPARTURE_LOCATION') {
          } else if (next == 'LOCATION_PICKER') {
          } else if (next == 'DRAW_ROUTE') {
          } else if (next == 'CREATE_TRIP') {
          } else if (next == 'FIND_DRIVER') {
          } else if (next == 'WAIT_DRIVER') {}
        });
        ref.read(mapProvider.notifier).setMapAction('');

        return GoogleMap(
          padding: EdgeInsets.fromLTRB(
              mapPaddingLeft, mapPaddingTop, mapPaddingRight, mapPaddingBottom),
          onMapCreated: (controller) {
            googleMapController = controller;
            controller.setMapStyle(mapTheme);
          },
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
              target: ref.read(currentLocationProvider).postion!, zoom: zoom),
          markers: markers,
          zoomControlsEnabled: false,
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              color: const Color.fromARGB(255, 255, 113, 36),
              width: 8,
            )
          },
          onCameraMove: (CameraPosition cameraPositiona) {
            cameraPosition = cameraPositiona; //when map is dragging
          },
          onCameraIdle: () async {
            if (ref.read(stepProvider) == 'departure_location_picker') {
              LatLng latLng = LatLng(cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              LocationModel locationModel = await setAddressByPosition(latLng);
              locationModel.structuredFormatting!.formatSecondaryText();
              ref
                  .read(departureLocationProvider.notifier)
                  .setDepartureLocation(locationModel);
            } else if (ref.read(stepProvider) == 'arrival_location_picker') {
              LatLng latLng = LatLng(cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              LocationModel locationModel = await setAddressByPosition(latLng);
              locationModel.structuredFormatting!.formatSecondaryText();
              ref
                  .read(arrivalLocationProvider.notifier)
                  .setArrivalLocation(locationModel);
            }
          },
        );
      },
    );
  }
}
