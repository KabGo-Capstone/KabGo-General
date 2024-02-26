import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

Future<LatLng> determinePosition() async {

  // if (await Permission.location.serviceStatus.isEnabled) {
  //   print('Permission is enabled');
  // } else {
  //   print('Permission is not enabled');
  // }

  // // var status = await Permission.locationWhenInUse.request();

  // final status = await Permission.location.request();

  // if (status.isGranted) {
  //   print('Granted');
  // } else if (status.isDenied) {
  //   print('Denied');
  // }

  // // ANDROID PERMISSION

  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    Geolocator.requestPermission();
    // Geolocator.openLocationSettings();
    // return Future.error('Location services are disabled');
  }
  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permission denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied');
  }

  Position position = await Geolocator.getCurrentPosition();
  return LatLng(position.latitude, position.longitude);
}
