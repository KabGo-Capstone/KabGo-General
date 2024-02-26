import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'notification/notifications.dart';
import 'app.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await Notifications().initNotifications();
  // await Permission.location.request();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
