import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:customer/functions/getBytesFromAsset.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../functions/determinePosition.dart';
import '../../../functions/networkUtility.dart';
import '../../../functions/setAddressByPosition.dart';
import '../../../models/location_model.dart';
import '../../../models/route_model.dart';
import '../../../providers/arrivalLocationProvider.dart';
import '../../../providers/currentLocationProvider.dart';
import '../../../providers/departureLocationProvider.dart';
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
  bool firstBuild = true;

  LatLng? departureLocation;
  LatLng? arrivalLocation;
  double mapPaddingTop = 25;
  double mapPaddingLeft = 10;
  double mapPaddingBottom = 180;
  double mapPaddingRight = 10;
  double padding = 100;
  dynamic parsedValue;
  double zoom = 16.5;
  bool isDrawRoute = true;
  bool locationMapPicker = false;

  int? route_width;
  bool departureLocationPicker = false;
  bool myLocationEnabled = true;

  final aniMarkers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();

  LatLng initCurrentLocation =
      const LatLng(10.770116329749964, 106.67144931904866);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    route_width = 0;
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
    departureLocationPicker = true;
    locationMapPicker = true;
    setState(() {});
  }

  void getNewCurrentLocation(bool animation) async {
    currentLocation = await determinePosition();
    LocationModel currentLocationModel =
        await setAddressByPosition(currentLocation!);
    currentLocationModel.structuredFormatting!.formatSecondaryText();
    ref
        .read(currentLocationProvider.notifier)
        .setCurrentLocation(currentLocationModel);
    animation
        ? googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLocation!, zoom: 16.5),
            ),
          )
        : googleMapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLocation!, zoom: 16.5),
            ),
          );
    setState(() {});
  }

  void drawRoute() async {
    LocationModel arrival = ref.read(arrivalLocationProvider);
    departureLocation = ref.read(departureLocationProvider).postion;
    if (arrival.postion == null) {
      arrivalLocation = await arrival.getLocation();
    } else {
      arrivalLocation = arrival.postion;
    }
    markers.clear();
    if (markers.isEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId('departureLocation'),
          position:
              LatLng(departureLocation!.latitude, departureLocation!.longitude),
          icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(
              'lib/assets/images/map_departure_icon.png',
              80,
            ),
          ),
        ),
      );
    }
    markers.add(
      Marker(
        markerId: const MarkerId('arrivalLocation'),
        position: LatLng(arrivalLocation!.latitude, arrivalLocation!.longitude),
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset('lib/assets/images/map_arrival_icon.png', 80),
        ),
      ),
    );

    Uri uri = Uri.https('maps.googleapis.com', 'maps/api/directions/json', {
      'key': APIKey,
      'origin':
          '${departureLocation!.latitude},${departureLocation!.longitude}',
      'destination':
          '${arrivalLocation!.latitude},${arrivalLocation!.longitude}',
    });

    String? response = await NetworkUtility.fetchUrl(uri);
    final parsed = json.decode(response!).cast<String, dynamic>();

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(
        parsed['routes'][0]['overview_polyline']['points'] as String);
    if (result.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      ref.read(routeProvider.notifier).setRoute(RouteModel(
          departureLocation: LocationModel(),
          arrivalLocation: LocationModel(),
          time: parsed['routes'][0]['legs'][0]['duration']['text'] as String,
          distance:
              parsed['routes'][0]['legs'][0]['distance']['text'] as String));
      Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        points: polylineCoordinates,
      );
      polylineList.clear();
      polylineList.add(polyline);
      _setMapFitToTour();
    });
    Future.delayed(Duration.zero, () {
      drawStepByStep(result);
    });
  }

  void drawStepByStep(List<PointLatLng> result) async {
    route_width = 7;
    polylineCoordinates.clear();
    // print(1000/result.length);

    for (var point in result) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      setState(() {});
      await Future.delayed(Duration(milliseconds: 1000 ~/ result.length));
    }
  }

  void _setMapFitToTour() {
    double minLat = polylineList.first.points.first.latitude;
    double minLong = polylineList.first.points.first.longitude;
    double maxLat = polylineList.first.points.first.latitude;
    double maxLong = polylineList.first.points.first.longitude;

    for (var poly in polylineList) {
      for (var point in poly.points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      }
    }

    googleMapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLong),
          northeast: LatLng(maxLat, maxLong),
        ),
        70));
  }

  void findDriver() async {
    departureLocation = ref.read(departureLocationProvider).postion;
    polylineList.clear();
    polylineCoordinates.clear();
    markers.clear();
    route_width = 0;

    const kMarkerId = MarkerId('currentLocation');
    var aniMarker = RippleMarker(
      markerId: const MarkerId('currentLocation'),
      position: departureLocation!,
      ripple: true,
      anchor: const Offset(0.5, 0.5),
      icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset('lib/assets/images/my_location.png', 150)),
    );
    setState(() => aniMarkers[kMarkerId] = aniMarker);
    googleMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                departureLocation!.latitude, departureLocation!.longitude),
            zoom: 15),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('===========> MY_MAP BUILD');

    String mapStep = ref.watch(mapProvider);

    if (mapStep == 'get_current_location') {
      ref.read(mapProvider.notifier).setMapAction('');
      getNewCurrentLocation(true);
    } else if (mapStep == 'arrival_location_picker') {
      ref.read(mapProvider.notifier).setMapAction('');
      getArrivalLocation();
    } else if (mapStep == 'departure_location_picker') {
      locationMapPicker = false;
      ref.read(mapProvider.notifier).setMapAction('');
      getDepartureLocation();
    } else if (mapStep == 'draw_route') {
      ref.read(mapProvider.notifier).setMapAction('');
      mapPaddingBottom = MediaQuery.of(context).size.height * 0.41;
      mapPaddingTop = MediaQuery.of(context).size.height * 0.15;

      setState(() {});
      Future.delayed(Duration.zero, () {
        drawRoute();
      });
    } else if (mapStep == 'find_driver') {
      ref.read(mapProvider.notifier).setMapAction('');
      mapPaddingBottom = MediaQuery.of(context).size.height * 0.15;
      mapPaddingTop = 25;
      myLocationEnabled = false;
      setState(() {});
      Future.delayed(Duration.zero, () {
        findDriver();
      });
    }

    if (firstBuild) {
      Future.delayed(Duration.zero, () {
        getNewCurrentLocation(false);
        firstBuild = false;
        locationMapPicker = true;
        // Future.delayed(Duration(milliseconds: 5), () {
        // });
      });
    }

    return Animarker(
      mapId: controller.future.then<int>((value) => value.mapId),
      rippleRadius: 0.3,
      rippleColor: const Color(0xffFFC4A9),
      rippleDuration: const Duration(milliseconds: 1500),
      markers: aniMarkers.values.toSet(),
      child: AbsorbPointer(
        absorbing: !locationMapPicker,
        child: GoogleMap(
          mapType: locationMapPicker ? MapType.normal : MapType.none,
          padding: EdgeInsets.fromLTRB(
              mapPaddingLeft, mapPaddingTop, mapPaddingRight, mapPaddingBottom),
          onMapCreated: (_controller) {
            controller.complete(_controller);
            googleMapController = _controller;
            _controller.setMapStyle(mapTheme);
          },
          myLocationButtonEnabled: false,
          myLocationEnabled: myLocationEnabled && locationMapPicker,
          initialCameraPosition:
              CameraPosition(target: initCurrentLocation, zoom: zoom),
          //             initialCameraPosition: CameraPosition(
          // target: ref.read(currentLocationProvider).postion!, zoom: zoom),
          markers: markers,
          zoomControlsEnabled: false,
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              color: const Color.fromARGB(255, 255, 113, 36),
              width: route_width!,
            )
          },
          onCameraMove: (CameraPosition cameraPositiona) {
            cameraPosition = cameraPositiona; //when map is dragging
          },
          onCameraIdle: () async {
            if (ref.read(stepProvider) == 'departure_location_picker' &&
                locationMapPicker) {
              LatLng latLng = LatLng(cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              LocationModel locationModel = await setAddressByPosition(latLng);
              locationModel.structuredFormatting!.formatSecondaryText();
              ref
                  .read(departureLocationProvider.notifier)
                  .setDepartureLocation(locationModel);
            } else if (ref.read(stepProvider) == 'arrival_location_picker' &&
                locationMapPicker) {
              LatLng latLng = LatLng(cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              LocationModel locationModel = await setAddressByPosition(latLng);
              locationModel.structuredFormatting!.formatSecondaryText();
              ref
                  .read(arrivalLocationProvider.notifier)
                  .setArrivalLocation(locationModel);
            }
          },
        ),
      ),
    );
  }
}
