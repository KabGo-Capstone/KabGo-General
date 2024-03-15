import 'package:dio/dio.dart';
import 'package:driver/providers/auth_provider.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/login_screen/footer/footer.dart';
import 'package:driver/widgets/login_screen/header/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

              context.push(data['redirect'], extra: {
                'firstName': data['user']['firstName'].toString(),
                'lastName': data['user']['lastName'].toString(),
                'phoneNumber': data['user']['phoneNumber'].toString(),
                'city': data['user']['city'].toString(),
                'referrerCode': data['user']['refererCode'].toString(),
                'email': data['user']['email'].toString(),
              });

              return;
            }
            context.push(data['redirect']);
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
