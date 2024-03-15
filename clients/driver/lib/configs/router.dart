import 'package:driver/models/user_register.dart';
import 'package:driver/providers/auth_provider.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/screens/register_screen/remind_info/remind_person_infor.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:driver/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:driver/animations/transitions.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _key = GlobalKey<NavigatorState>();

final router = Provider<GoRouter>(
  (ref) {
    // final authState = ref.watch(authProvider);
    // final phoneNumberAuthState = ref.watch(phoneAuthProvider);

    // final redirectLocation = phoneNumberAuthState.redirectPath;
    // if (redirectLocation != null && redirectLocation.isNotEmpty) {
    //   phoneNumberAuthState.clearRedirect();
    // }

    return GoRouter(
      navigatorKey: _key,
      initialLocation: SplashScreen.path,
      routes: [
        GoRoute(
          path: SplashScreen.path,
          name: SplashScreen.name,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: LoginScreen.path,
          name: LoginScreen.name,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RegisterScreen.path,
          name: RegisterScreen.name,
          pageBuilder: (context, state) => buildPageWithSlideUpTransition(
            context: context,
            key: state.pageKey,
            child: const RegisterScreen(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: OTPScreen.path,
          name: OTPScreen.name,
          builder: (context, state) {
            final userRegistration =
                UserRegister.fromJson(state.extra! as Map<String, String>);
            return OTPScreen(user: userRegistration);
          },
        ),
        GoRoute(
          path: SelectService.path,
          name: SelectService.name,
          pageBuilder: (context, state) => buildPageWithSlideUpTransition(
            context: context,
            key: state.pageKey,
            child: const SelectService(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: InfoRegister.path,
          name: InfoRegister.name,
          builder: (context, state) {
            return const InfoRegister();
          },
        ),
        GoRoute(
          path: '/remind_person_image',
          name: 'remind_person_image',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const RemindPersonImage(),
              transitionDuration: const Duration(microseconds: 250),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                          .animate(animation),
                  child: child,
                );
              },
            );
          },
        )
      ],
    );
  },
);
