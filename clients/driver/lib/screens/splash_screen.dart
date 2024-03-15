import 'dart:convert';

import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerWidget {
  static const path = '/splash';
  static const name = 'splash_screen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void checkingSession() {
      SharedPreferences.getInstance().then((prefs) {
        final userProfile = prefs.getString('user-profile');

        if (userProfile != null && userProfile.isNotEmpty) {
          final userProfileMap = jsonDecode(userProfile);

          final driverInfoNotifier =
              ref.read(driverInfoRegisterProvider.notifier);

          driverInfoNotifier.setIdDriver(userProfileMap['id']);
          driverInfoNotifier.setLastName(userProfileMap['lastName']);
          driverInfoNotifier.setFirstName(userProfileMap['firstName']);
          driverInfoNotifier.setPhoneNumber(userProfileMap['phoneNumber']);

          if (userProfileMap['serviceID'] != null &&
              userProfileMap['serviceID'] != '') {
            context.pushReplacement(SelectService.path);
            context.push(InfoRegister.path);
          }
          else {
            if (userProfileMap['verified'] == true) {
              // context.go(Home);
            } 
            else {
              context.go(SelectService.path);
            }
          }
        } else {
          context.go(LoginScreen.path);
        }
      });
    }

    checkingSession();

    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage('assets/logo.png'),
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
