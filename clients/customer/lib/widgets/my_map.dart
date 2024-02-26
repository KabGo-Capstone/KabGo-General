import 'dart:async';
import 'dart:convert';
import 'package:customer/functions/convertStringToListPoint.dart';
import 'package:customer/providers/coupon_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customer/functions/determinePosition.dart';
import 'package:customer/functions/getBytesFromAsset.dart';
import 'package:customer/functions/networkUtility.dart';
import 'package:customer/functions/setAddressByPosition.dart';
import 'package:customer/models/customer_model.dart';
import 'package:customer/models/driver_model.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/models/route_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/currentLocationProvider.dart';
import 'package:customer/providers/customerProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/driverProvider.dart';
import 'package:customer/providers/locationPickerInMap.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/routeProvider.dart';
import 'package:customer/providers/socketProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/utils/Google_Api_Key.dart';

class MyMap extends ConsumerStatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends ConsumerState<MyMap> {
  final controller = Completer<GoogleMapController>();
  late GoogleMapController googleMapController;
  CameraPosition? cameraPosition;
  String mapTheme = '';
  Set<Marker> markers = {};
  Set<Marker> _markers = {};
  final aniMarkers = <MarkerId, Marker>{};

  List<LatLng> polylineCoordinates = [];
  LatLng? currentLocation;
  Set<Polyline> polylineList = {};
  Set<Polyline> polylines = const <Polyline>{};
  BitmapDescriptor? bitmapDescriptor;

  double distance = 0;
  double travelTime = 0;

  LatLng? departureLocation;
  LatLng? arrivalLocation;
  double mapPaddingTop = 25;
  double mapPaddingLeft = 0;
  double mapPaddingBottom = 0;
  double mapPaddingRight = 0;
  dynamic parsedValue;
  double zoom = 15;
  bool isDrawRoute = true;

  void initLocation() async {
    LatLng latLng = await determinePosition();
    LocationModel currentLocationModel = await setAddressByPosition(latLng);
    currentLocationModel.structuredFormatting!.formatSecondaryText();
    ref
        .read(departureLocationProvider.notifier)
        .setDepartureLocation(currentLocationModel);
    ref.read(currentLocationProvider.notifier).setCurrentLocation(latLng);
  }

  void getDeparture(bool animationCamera) async {
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

    if (animationCamera) {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  departureLocation!.latitude, departureLocation!.longitude),
              zoom: 16.5),
        ),
      );
    } else {
      googleMapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  departureLocation!.latitude, departureLocation!.longitude),
              zoom: 16.5),
        ),
      );
    }

    setState(() {});
  }

  void getNewCurrentLocation() async {
    currentLocation = await determinePosition();
    ref
        .read(currentLocationProvider.notifier)
        .setCurrentLocation(currentLocation!);

    markers.remove(const MarkerId('currentLocation'));
    if (ref.read(stepProvider) != 'choose_departure') {
      // ignore: collection_methods_unrelated_type
      markers.add(Marker(
        anchor: const Offset(0.5, 0.5),
        markerId: const MarkerId('currentLocation'),
        position: currentLocation!,
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset('lib/assets/my_location.png', 250)),
      ));
    }
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation!, zoom: 16.5),
      ),
    );
    setState(() {});
  }

  void getCurrentLocation() async {
    currentLocation = ref.read(currentLocationProvider);

    // ignore: collection_methods_unrelated_type
    markers.remove(const MarkerId('currentLocation'));
    markers.add(Marker(
      anchor: const Offset(0.5, 0.5),
      markerId: const MarkerId('currentLocation'),
      position: currentLocation!,
      icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset('lib/assets/my_location.png', 250)),
    ));
    googleMapController.animateCamera(
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

    if (markers.isEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId('departureLocation'),
          position:
              LatLng(departureLocation!.latitude, departureLocation!.longitude),
          icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset(
              'lib/assets/map_departure_icon.png',
              80,
            ),
          ),
        ),
      );
    }
    // ignore: collection_methods_unrelated_type
    markers.remove(const MarkerId('arrivalLocation'));
    markers.add(
      Marker(
        markerId: const MarkerId('arrivalLocation'),
        position: LatLng(arrivalLocation!.latitude, arrivalLocation!.longitude),
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset('lib/assets/map_arrival_icon.png', 80),
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
    print('in trong day ${ref.read(mapProvider)}');

    setState(() {
      ref.read(routeProvider.notifier).setRoute(RouteModel(
          departureLocation: LocationModel(),
          arrivalLocation: LocationModel(),
          time: parsed['routes'][0]['legs'][0]['duration']['text'] as String,
          distance:
              parsed['routes'][0]['legs'][0]['distance']['text'] as String));
      Polyline polyline = Polyline(
        polylineId: const PolylineId('poly'),
        points: polylineCoordinates,
      );
      polylineList.clear();
      polylineList.add(polyline);
      _setMapFitToTour();
    });
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

    const kMarkerId = MarkerId('currentLocation');
    var aniMarker = RippleMarker(
      markerId: const MarkerId('currentLocation'),
      position: departureLocation!,
      ripple: true,
      anchor: const Offset(0.5, 0.5),
      icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset('lib/assets/my_location.png', 150)),
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

  void moveToPosition() {
    departureLocation = ref.read(departureLocationProvider).postion;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                departureLocation!.latitude, departureLocation!.longitude),
            zoom: 16.5),
      ),
    );
  }

  void drawDriver() async {
    RouteModel routeModel = ref.read(routeProvider);
    bitmapDescriptor =
        (routeModel.service == 'Xe máy' || routeModel.service == 'Xe tay ga')
            ? BitmapDescriptor.fromBytes(
                await getBytesFromAsset('lib/assets/bike_image.png', 75))
            : BitmapDescriptor.fromBytes(
                await getBytesFromAsset('lib/assets/car_image.png', 60));
    for (dynamic i in parsedValue) {
      // print(i['infor']['rotation'].toString());
      markers.add(
        Marker(
          rotation: double.parse(i['infor']['rotation'].toString()),
          anchor: const Offset(0.5, 0.5),
          markerId: MarkerId('departureLocation_$i'),
          position: LatLng(
              double.parse(i['infor']['coordinate']['latitude'].toString()),
              double.parse(i['infor']['coordinate']['longitude'].toString())),
          icon: bitmapDescriptor!,
        ),
      );
    }
    setState(() {});
  }

  void drawRouteDriver() async {
    departureLocation = ref.read(departureLocationProvider).postion;
    DriverModel driverModel = ref.read(driverProvider);
    markers.clear();

    _markers.add(
      Marker(
        markerId: const MarkerId('departureLocation'),
        anchor: const Offset(0.5, 0.5),
        position:
            LatLng(departureLocation!.latitude, departureLocation!.longitude),
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset(
            'lib/assets/map_departure_icon.png',
            80,
          ),
        ),
      ),
    );

    markers = {
      ..._markers,
      Marker(
        rotation: double.parse(driverModel.rotation.toString()),
        markerId: const MarkerId('driverLocation'),
        anchor: const Offset(0.5, 0.5),
        position: LatLng(
            double.parse(driverModel.coordinate['latitude'].toString()),
            double.parse(driverModel.coordinate['longitude'].toString())),
        icon: bitmapDescriptor!,
      ),
    };

    Uri uri = Uri.https('maps.googleapis.com', 'maps/api/directions/json', {
      'key': APIKey,
      'destination':
          '${departureLocation!.latitude},${departureLocation!.longitude}',
      'origin':
          '${driverModel.coordinate['latitude']},${driverModel.coordinate['longitude']}',
    });

    String? response = await NetworkUtility.fetchUrl(uri);
    final parsed = json.decode(response!).cast<String, dynamic>();
    String distance =
        parsed['routes'][0]['legs'][0]['distance']['text'] as String;
    double distanceValue = double.parse(distance.split(' ')[0]);
    String distanceUnit = distance.split(' ')[1];
    if (distanceUnit == 'km') {
      if (distanceValue < 0.1) {
        isDrawRoute = false;
      }
    } else {
      if (distanceValue < 100) {
        isDrawRoute = false;
      }
    }

    polylineList.clear();
    polylineCoordinates.clear();

    if (isDrawRoute) {
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> result = polylinePoints.decodePolyline(
          parsed['routes'][0]['overview_polyline']['points'] as String);
      if (result.isNotEmpty) {
        polylineCoordinates.clear();
        for (var point in result) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }

      Polyline polyline = Polyline(
        polylineId: const PolylineId('poly'),
        points: polylineCoordinates,
      );
      polylineList.add(polyline);
      _setMapFitToTour();
    }
    setState(() {});
  }

  void drawDriverMoving(String value) async {
    DriverModel driverModel = ref.read(driverProvider);
    markers.removeWhere(
        (element) => element.markerId == const MarkerId('driverLocation'));
    markers = {
      ..._markers,
      Marker(
        rotation: double.parse(driverModel.rotation.toString()),
        markerId: const MarkerId('driverLocation'),
        anchor: const Offset(0.5, 0.5),
        position: LatLng(
            double.parse(driverModel.coordinate['latitude'].toString()),
            double.parse(driverModel.coordinate['longitude'].toString())),
        icon: bitmapDescriptor!,
      ),
    };

    List<Map<String, String>> listValue = convertStringToListOfMaps(value);

    if (listValue.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in listValue) {
        // print('point: $point');
        polylineCoordinates.add(LatLng(
            double.parse(point['lat']!), double.parse(point['longitude']!)));
      }

      setState(() {
        polylineList.clear();
        Polyline polyline = Polyline(
          polylineId: const PolylineId('poly'),
          points: polylineCoordinates,
        );
        polylineList.add(polyline);
        // _setMapFitToTour();
      });
    }
  }

  void drawRouteToArrival(String value) async {
    List<Map<String, String>> listValue = convertStringToListOfMaps(value);

    DriverModel driverModel = ref.read(driverProvider);

    markers = {
      ..._markers,
      Marker(
        rotation: double.parse(driverModel.rotation.toString()),
        markerId: const MarkerId('driverLocation'),
        anchor: const Offset(0.5, 0.5),
        position: LatLng(double.parse(listValue[0]['lat'].toString()),
            double.parse(listValue[0]['longitude'].toString())),
        icon: bitmapDescriptor!,
      ),
    };

    if (listValue.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in listValue) {
        // print('point: $point');
        polylineCoordinates.add(LatLng(
            double.parse(point['lat']!), double.parse(point['longitude']!)));
      }

      setState(() {
        polylineList.clear();
        Polyline polyline = Polyline(
          polylineId: const PolylineId('poly'),
          points: polylineCoordinates,
        );
        polylineList.add(polyline);
        if (ref.read(stepProvider) != 'moving') {
          _setMapFitToTour();
        }
      });
    }
  }

  String? action;

  Future<void> bookCar() async {
    SocketClient socketClient = ref.read(socketClientProvider.notifier);
    LocationModel departure = ref.read(departureLocationProvider);
    LocationModel arrival = ref.read(arrivalLocationProvider);
    RouteModel routeModel = ref.read(routeProvider);
    CustomerModel customerModel = ref.read(customerProvider);
    socketClient.emitBookingCar(departure, arrival, routeModel, customerModel);
    ref.read(stepProvider.notifier).setStep('find_driver');
    ref.read(mapProvider.notifier).setMapAction('FIND_DRIVER');
    ref.read(couponProvider.notifier).setCoupon(0);
  }

  @override
  void initState() {
    super.initState();

    initLocation();
    getNewCurrentLocation();

    SocketClient socketClient = ref.read(socketClientProvider.notifier);
    socketClient.subscribe('send drivers', (dynamic value) {
      print('send drivers');
      parsedValue = json.decode(value!).cast<dynamic>();
      drawDriver();
    });

    socketClient.subscribe('submit driver', (dynamic value) {
      print('submit driver');
      dynamic parsed = json.decode(value).cast<String, dynamic>();
      ref.read(driverProvider.notifier).setDriver(DriverModel.fromMap(parsed));
      ref.read(mapProvider.notifier).setMapAction('WAIT_DRIVER');
    });

    socketClient.subscribe('reject driver', (dynamic value) {
      print('reject driver');
      bookCar();
    });

    socketClient.subscribe('moving driver', (dynamic value) {
      print('moving driver');
      dynamic parsed = json.decode(value).cast<String, dynamic>();
      ref
          .read(driverProvider.notifier)
          .setDriver(DriverModel.fromMap(parsed['driver']));
      // print(parsed['directions']);
      if (parsed['directions'].toString().length > 2) {
        if (ref.read(stepProvider) == 'wait_driver') {
          drawDriverMoving(parsed['directions']);
        } else {
          ref.read(stepProvider.notifier).setStep('moving');
          drawRouteToArrival(parsed['directions']);
        }
      }
    });

    socketClient.subscribe('comming driver', (dynamic value) async {
      print('comming driver');
      dynamic parsed = json.decode(value).cast<String, dynamic>();
      ref
          .read(driverProvider.notifier)
          .setDriver(DriverModel.fromMap(parsed['driver']));
      ref.read(stepProvider.notifier).setStep('comming_driver');
      LocationModel arrival = ref.read(arrivalLocationProvider);
      _markers = {
        Marker(
          markerId: const MarkerId('arrivalLocation'),
          position:
              LatLng(arrival.postion!.latitude, arrival.postion!.longitude),
          icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset('lib/assets/map_arrival_icon.png', 80),
          ),
        )
      };
      drawRouteToArrival(parsed['directions']);
    });

    socketClient.subscribe('success driver', (dynamic value) {
      ref.read(mapProvider.notifier).setMapAction('SET_DEFAULT');
      ref.read(stepProvider.notifier).setStep('complete');
    });

    DefaultAssetBundle.of(context)
        .loadString('lib/assets/map.json')
        .then((value) => mapTheme = value);
  }

  @override
  Widget build(BuildContext context) {
    print('===========> MY_MAP BUILD');

    return Consumer(
      builder: (context, ref, child) {
        ref.listen(mapProvider, (previous, next) {
          if (next == 'GET_CURRENT_LOCATION') {
            getNewCurrentLocation();
          } else if (next == 'SET_DEFAULT') {
            getCurrentLocation();
            setState(() {
              mapPaddingBottom = 100;
              markers.clear();
              polylineList.clear();
              polylineCoordinates.clear();
            });
          } else if (next == 'FIND_ARRIVAL_LOCATION') {
            setState(() {
              mapPaddingBottom = 320;
              markers.clear();
              polylineList.clear();
              polylineCoordinates.clear();
            });
          } else if (next == 'GET_CURRENT_DEPARTURE_LOCATION') {
            getDeparture(false);
          } else if (next == 'GET_NEW_DEPARTURE_LOCATION') {
            polylineList.clear();
            polylineCoordinates.clear();
            markers.clear();
            getDeparture(true);
          } else if (next == 'LOCATION_PICKER') {
            setState(() {
              markers.clear();
              polylineList.clear();
              polylineCoordinates.clear();
            });
            moveToPosition();
          } else if (next == 'DRAW_ROUTE') {
            drawRoute();
          } else if (next == 'CREATE_TRIP') {
          } else if (next == 'FIND_DRIVER') {
            polylineList.clear();
            polylineCoordinates.clear();
            markers.clear();
            findDriver();
          } else if (next == 'WAIT_DRIVER') {
            ref.read(stepProvider.notifier).setStep('wait_driver');
            drawRouteDriver();
          }
        });
        ref.read(mapProvider.notifier).setMapAction('');

        return Animarker(
          mapId: controller.future.then<int>((value) => value.mapId),
          rippleRadius: 0.4,
          rippleColor: const Color(0xffFFC4A9),
          rippleDuration: const Duration(milliseconds: 1500),
          markers: aniMarkers.values.toSet(),
          child: GoogleMap(
            padding: EdgeInsets.fromLTRB(0, 80, 0, mapPaddingBottom),
            onMapCreated: (_controller) {
              controller.complete(_controller);
              googleMapController = _controller;
              _controller.setMapStyle(mapTheme);
            },
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            initialCameraPosition: CameraPosition(
                target: const LatLng(10.762898829981317, 106.68242875171526),
                zoom: zoom),
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
              if (ref.read(stepProvider) == 'location_picker') {
                LatLng latLng = LatLng(cameraPosition!.target.latitude,
                    cameraPosition!.target.longitude);
                LocationModel locationModel =
                    await setAddressByPosition(latLng);
                locationModel.structuredFormatting!.formatSecondaryText();
                ref
                    .read(pickerLocationProvider.notifier)
                    .setPickerLocation(locationModel);
              } else if (ref.read(stepProvider) == 'choose_departure') {
                LatLng latLng = LatLng(cameraPosition!.target.latitude,
                    cameraPosition!.target.longitude);
                LocationModel locationModel =
                    await setAddressByPosition(latLng);
                locationModel.structuredFormatting!.formatSecondaryText();
                ref
                    .read(departureLocationProvider.notifier)
                    .setDepartureLocation(locationModel);
              }
            },
          ),
        );
      },
    );
  }
}
