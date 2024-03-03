import 'package:driver/screens/login_screen.dart';
// import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/screens/splash_screen.dart';
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
  // GoRoute(
  //   path: OTPScreen.path,
  //   name: OTPScreen.name,
  //   builder: (context, state) => const OTPScreen(data: '',),
  // )
]);
