import 'dart:convert';

import 'package:driver/firebase/auth/google_sign_in.dart';
import 'package:driver/providers/auth_provider.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:driver/widgets/login_screen/footer/footer.dart';
import 'package:driver/widgets/login_screen/header/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerWidget {
  static const path = '/login';
  static const name = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    handleSignInWithGoogle() {
      final googleProvider = ref.read(googleAuthProvider);

      Future.delayed(const Duration(milliseconds: 250), () {
        googleProvider.signIn().then((credential) async {
          if (credential == null) return;

          final driverInfoProvider =
              ref.read(driverInfoRegisterProvider.notifier);

          googleProvider.googleValidate(LoginScreen.path).then((data) {
            final email = googleProvider.user!.email;
            driverInfoProvider.setEmailDriver(email!);

            if (data['redirect'] == OTPScreen.path) {
              ref.watch(phoneAuthProvider).signIn(data['user']['phoneNumber']);

              GoogleSignInController.signOut().then((value) {
                context.push(data['redirect'], extra: {
                  'firstName': data['user']['firstName'].toString(),
                  'lastName': data['user']['lastName'].toString(),
                  'phoneNumber': data['user']['phoneNumber'].toString(),
                  'city': data['user']['city'].toString(),
                  'referrerCode': data['user']['refererCode'].toString(),
                  'email': data['user']['email'].toString(),
                });
              });

              return;
            }
            GoogleSignInController.signOut().then((value) {
              if (data['redirect'] == LoginScreen.path) {
                context.push(data['redirect']);
              } else {
                SharedPreferences.getInstance().then((prefs) {
                  if (data['user'] != null) {
                    prefs.setString('user-profile', jsonEncode(data['user']));
                  }

                  final driverInfoNotifier =
                      ref.read(driverInfoRegisterProvider.notifier);

                  driverInfoNotifier.setIdDriver(data['user']['id']);
                  driverInfoNotifier.setLastName(data['user']['lastName']);
                  driverInfoNotifier.setFirstName(data['user']['firstName']);
                  driverInfoNotifier
                      .setPhoneNumber(data['user']['phoneNumber']);

                  if (data['redirect'] == InfoRegister.path) {
                    context.pushReplacement(SelectService.path);
                    context.push(data['redirect']);
                  } else {
                    context.go(data['redirect']);
                  }
                });
              }
            });
          });
        });
      });
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              const LoginTitle(),
              const Spacer(flex: 4),
              LoginFooter(onRegisterPressed: handleSignInWithGoogle),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
