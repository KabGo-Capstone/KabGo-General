import 'package:driver/screens/login_screen.dart';
// import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/screens/register_screen/remind_info/remind_person_infor.dart';
import 'package:driver/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: SplashScreen.path, routes: [
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
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/remind_person_image',
    name: 'remind_person_image',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const RemindPersonImage(),
        transitionDuration: const Duration(microseconds: 250),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        },
      );
    },
  )
]);
