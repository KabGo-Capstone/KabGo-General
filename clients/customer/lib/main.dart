import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'notification/notifications.dart';
import 'package:customer/app.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await Notifications().initNotifications();

  // Modified by Quang Thanh on 20.02.2024 to handle logic localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Locale currentLocale = const Locale('vi');
  final prefs = await SharedPreferences.getInstance();
  final String? currentLanguageStorage = prefs.getString('language');

  if (currentLanguageStorage != null) {
    currentLocale = Locale(currentLanguageStorage);
  } else {
    currentLocale = const Locale('vi');
  }
  currentLocale = const Locale('vi');
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('vi')],
        path: 'lib/assets/translations',
        fallbackLocale: currentLocale,
        startLocale: currentLocale,
        child: const App(),
      ),
    ),
  );
}
