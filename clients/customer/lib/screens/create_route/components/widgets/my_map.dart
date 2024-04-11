import 'dart:convert';
import 'dart:async';

import 'package:customer/functions/getBytesFromAsset.dart';
import 'package:customer/models/driver_model.dart';
import 'package:customer/providers/driverProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/socketProvider.dart';
import 'package:customer/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../../../functions/determinePosition.dart';
import '../../../../functions/networkUtility.dart';
import '../../../../functions/setAddressByPosition.dart';
import '../../../../models/location_model.dart';
import '../../../../models/route_model.dart';
import '../../../../providers/arrivalLocationProvider.dart';
import '../../../../providers/currentLocationProvider.dart';
import '../../../../providers/departureLocationProvider.dart';
import '../../../../providers/routeProvider.dart';
import '../../../../providers/stepProvider.dart';
import '../../../../utils/Google_Api_Key.dart';
import 'dart:math' as math;

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
  dynamic parsedValue = [];
  double zoom = 16.5;
  bool isDrawRoute = true;
  bool locationMapPicker = false;

  int nearDriverCount = 0;
  bool rippleMarker = true;

  int routeWidth = 0;
  bool departureLocationPicker = false;
  bool myLocationEnabled = true;

  SocketClient? socketClient;

  var aniMarkers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();

  LatLng initCurrentLocation =
      const LatLng(10.770116329749964, 106.67144931904866);

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
    routeWidth = 7;
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

  void showNearDriver() async {
    bitmapDescriptor ??= BitmapDescriptor.fromBytes(
        await getBytesFromAsset('lib/assets/images/bike_image.png', 75));
    markers.clear();
    for (dynamic i in parsedValue) {
      logger.d(i);
      logger.d(i['position']['lat']);
      logger.d(i['position']['lng']);
      logger.d(i['position']['bearing']);
      markers.add(
        Marker(
          rotation: double.parse(i['position']['bearing'].toString()),
          anchor: const Offset(0.5, 0.5),
          markerId: MarkerId('departureLocation_$i'),
          position: LatLng(
            double.parse(i['position']['lat'].toString()),
            double.parse(i['position']['lng'].toString()),
          ),
          icon: bitmapDescriptor!,
        ),
      );
    }
    nearDriverCount++;
    setState(() {});
  }

  double calculateBearing(LatLng currentLocation, LatLng destinationPosition) {
    final bearing = math.atan2(
        math.sin(math.pi *
            (destinationPosition.longitude - currentLocation.longitude) /
            180.0),
        math.cos(math.pi * currentLocation.latitude / 180.0) *
                math.tan(math.pi * destinationPosition.latitude / 180.0) -
            math.sin(math.pi * currentLocation.latitude / 180.0) *
                math.cos(math.pi *
                    (destinationPosition.longitude -
                        currentLocation.longitude) /
                    180.0));

    return bearing * 180.0 / math.pi;
  }

  void drawRouteDriver() async {
    departureLocation = ref.read(departureLocationProvider).postion;
    DriverModel driverModel = ref.read(driverProvider);
    markers.clear();

    const kMarkerId = MarkerId('currentLocation');
    aniMarkers[kMarkerId] = const RippleMarker(
      markerId: MarkerId('currentLocation'),
    );
    rippleMarker = false;

    logger.d(0);

    markers.add(
      Marker(
        markerId: const MarkerId('departureLocation'),
        anchor: const Offset(0.5, 0.5),
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

    markers.add(
      Marker(
        rotation: double.parse(driverModel.position['bearing'].toString()),
        markerId: const MarkerId('driverLocation'),
        anchor: const Offset(0.5, 0.5),
        position: LatLng(10.767822219151824, 106.68398031556467),
        icon: bitmapDescriptor!,
      ),
    );

    logger.d(1);
    //10.767822219151824, 106.68398031556467

    Uri uri = Uri.https('maps.googleapis.com', 'maps/api/directions/json', {
      'key': APIKey,
      'origin':
          '${departureLocation!.latitude},${departureLocation!.longitude}',
      'destination': '10.767822219151824,106.68398031556467',
    });

    String? response = await NetworkUtility.fetchUrl(uri);
    final parsed = json.decode(response!).cast<String, dynamic>();
    logger.d(2);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(
        parsed['routes'][0]['overview_polyline']['points'] as String);
    if (result.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    logger.d(3);

    setState(() {
      Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        points: polylineCoordinates,
      );
      polylineList.clear();
      polylineList.add(polyline);
      _setMapFitToTour();
    });
  }

  List<Map<String, String>> convertStringToListOfMaps(String input) {
    input = input.replaceAll("[", "").replaceAll("]", "");
    List<String> pairs = input.split(", ");
    List<Map<String, String>> result = [];

    pairs.forEach((pair) {
      List<String> keyValueStrings = pair.split(" / ");
      Map<String, String> keyValueMap = {};

      keyValueStrings.forEach((keyValueString) {
        List<String> keyValue = keyValueString.split(": ");
        if (keyValue.length == 2) {
          String key = keyValue[0].trim();
          String value = keyValue[1].trim();
          keyValueMap[key] = value;
        }
      });

      result.add(keyValueMap);
    });

    return result;
  }

  void drawDriverMoveToDeparture(List<PointLatLng> polylinePointsTemp) async {
    markers.removeWhere(
        (element) => element.markerId == const MarkerId('driverLocation'));

    markers.add(
      Marker(
        rotation: 30,
        markerId: const MarkerId('driverLocation'),
        anchor: const Offset(0.5, 0.5),
        position: LatLng(polylinePointsTemp.last.latitude,
            polylinePointsTemp.last.longitude),
        icon: bitmapDescriptor!,
      ),
    );

    polylineCoordinates.clear();

    for (var point in polylinePointsTemp) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    setState(() {});
    // ref.read(stepProvider.notifier).setStep('comming_driver');
  }

  @override
  void initState() {
    super.initState();

    socketClient = ref.read(socketClientProvider.notifier);
    // socketClient!.subscribe('state-change', (dynamic data) {
    //   if (data['status'] == 'CREATED') {
    //     socketClient!.emitLocateDriver(data);
    //     ref.read(stepProvider.notifier).setStep('find_driver');
    //     ref.read(mapProvider.notifier).setMapAction('find_driver');
    //   }
    // });

    DefaultAssetBundle.of(context)
        .loadString('lib/assets/jsons/map.json')
        .then((value) => mapTheme = value);
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
      socketClient!.subscribe('locating-driver', (dynamic value) {
        // print('loading-driver: $value');
        // print('\n');
        showNearDriver();
        parsedValue = [];
        for (var item in value) {
          parsedValue.add(item);
        }
        showNearDriver();
      });
      socketClient!.subscribe('driver-accepted', (dynamic value) {
        logger.d('ACCEPT-DRIVER');
        // print('\n');
        logger.d(value['driverInfo']);
        DriverModel driver = DriverModel.fromMap(value['driverInfo']);
        ref.read(driverProvider.notifier).setDriver(driver);

        ref.read(stepProvider.notifier).setStep('wait_driver');
        ref.read(mapProvider.notifier).setMapAction('wait_driver');
      });
      ref.read(mapProvider.notifier).setMapAction('');
      mapPaddingBottom = MediaQuery.of(context).size.height * 0.15;
      mapPaddingTop = 25;
      myLocationEnabled = false;
      routeWidth = 0;
      setState(() {});
      Future.delayed(Duration.zero, () {
        findDriver();
      });
    } else if (mapStep == 'wait_driver') {
      ref.read(mapProvider.notifier).setMapAction('');
      routeWidth = 7;
      mapPaddingBottom = MediaQuery.of(context).size.height * 0.23;
      drawRouteDriver();
    } else if (mapStep == 'comming_driver') {
    } else if (mapStep == 'moving') {
    } else if (mapStep == 'complete') {}

    if (firstBuild) {
      Future.delayed(Duration.zero, () {
        getNewCurrentLocation(false);
        firstBuild = false;
        locationMapPicker = true;
      });
    }

    return Animarker(
      mapId: controller.future.then<int>((value) => value.mapId),
      rippleRadius: 0.3,
      shouldAnimateCamera: rippleMarker,
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
          markers: markers,
          zoomControlsEnabled: false,
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              color: const Color.fromARGB(255, 255, 113, 36),
              width: routeWidth,
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
