import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/models/driver_service.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/home_dashboard/home_dashboard.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:driver/services/dio_client.dart';
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
              userProfileMap['serviceID'] != '' &&
              !userProfileMap['verified']) {
            context.pushReplacement(SelectService.path);
            context.push(InfoRegister.path);
          } else {
            if (userProfileMap['verified'] == true) {
              driverInfoNotifier.setAvatar(userProfileMap['avatar']);

              final dioClient = DioClient();
              final response = dioClient.request('/verify-user-registration',
                  options: Options(method: 'POST'), data: {}).then((response) {
                if (response.statusCode == 200) {
                  final services = [];
                  final List<dynamic> serviceListJson =
                      response.data['data']['services'];
                  for (var json in serviceListJson) {
                    services.add(Service.fromJson(json));
                  }

                  for (var service in services) {
                    if (service.id == userProfileMap['serviceID']) {
                      driverInfoNotifier.setServiceName(service.name);
                      break;
                    }
                  }
                }
                context.go(HomeDashboard.path);
              });
            } else {
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
