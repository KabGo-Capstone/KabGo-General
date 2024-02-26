import 'package:driver/screens/login_screen.dart';
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
]);
