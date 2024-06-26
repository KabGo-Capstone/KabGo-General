import 'package:driver/models/user_register.dart';
import 'package:driver/screens/customer_request/customer_request.dart';
import 'package:driver/screens/customer_request/customer_request_accept.dart';
import 'package:driver/screens/customer_request/customer_request_comming.dart';
import 'package:driver/screens/customer_request/customer_request_ongoing.dart';
import 'package:driver/screens/customer_request/customer_request_ready.dart';
import 'package:driver/screens/home_dashboard/home_dashboard.dart';
import 'package:driver/screens/home_income/home_income.dart';
import 'package:driver/screens/home_screen/index.dart';
import 'package:driver/screens/home_wallet/home_wallet.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/info_detail/driving_license.dart';
import 'package:driver/screens/register_screen/info_detail/driving_register.dart';
import 'package:driver/screens/register_screen/info_detail/emergency_contact.dart';
import 'package:driver/screens/register_screen/info_detail/id_person.dart';
import 'package:driver/screens/register_screen/info_detail/person_image.dart';
import 'package:driver/screens/register_screen/info_detail/vehicle_info.dart';
import 'package:driver/screens/register_screen/info_detail/vehicle_insurance.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/screens/register_screen/remind_info/remind_person_infor.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:driver/screens/route_screen/route_screen.dart';
import 'package:driver/screens/splash_screen.dart';
import 'package:driver/screens/vehicle_screen/vehicle_screen.dart';
import 'package:driver/widgets/driver_panel/driver_panel.dart';
import 'package:driver/widgets/home_panel/home_panel.dart';
import 'package:driver/widgets/route_panel/route_panel.dart';
import 'package:flutter/material.dart';
import 'package:driver/animations/transitions.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _key = GlobalKey<NavigatorState>();

final _shellkey = GlobalKey<NavigatorState>(debugLabel: 'Shell Navigator');
final _shellStatusKey =
    GlobalKey<NavigatorState>(debugLabel: 'Shell Status Navigator');
final _shellDriverKey =
    GlobalKey<NavigatorState>(debugLabel: 'Shell Driver Navigator');
final _shellRouteKey =
    GlobalKey<NavigatorState>(debugLabel: 'Shell Route Navigator');

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
          pageBuilder: (context, state) => buildPageWithSlideUpTransition(
            context: context,
            key: state.pageKey,
            child: const InfoRegister(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: PersonImage.path,
          name: PersonImage.name,
          pageBuilder: (context, state) => buildPageWithSlideInTransition(
            context: context,
            key: state.pageKey,
            child: const PersonImage(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: IdPersonInfo.path,
          name: IdPersonInfo.name,
          pageBuilder: (context, state) => buildPageWithSlideInTransition(
            context: context,
            key: state.pageKey,
            child: const IdPersonInfo(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: DivingLicense.path,
          name: DivingLicense.name,
          pageBuilder: (context, state) => buildPageWithSlideInTransition(
            context: context,
            key: state.pageKey,
            child: const DivingLicense(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: EmergencyContactInfo.path,
          name: EmergencyContactInfo.name,
          pageBuilder: (context, state) => buildPageWithSlideInTransition(
            context: context,
            key: state.pageKey,
            child: const EmergencyContactInfo(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: VehicleInfo.path,
          name: VehicleInfo.name,
          pageBuilder: (context, state) => buildPageWithSlideInTransition(
            context: context,
            key: state.pageKey,
            child: const VehicleInfo(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: DrivingRegister.path,
          name: DrivingRegister.name,
          pageBuilder: (context, state) => buildPageWithSlideInTransition(
            context: context,
            key: state.pageKey,
            child: const DrivingRegister(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
        ),
        GoRoute(
          path: VehicleInsurance.path,
          name: VehicleInsurance.name,
          pageBuilder: (context, state) => buildPageWithSlideInTransition(
            context: context,
            key: state.pageKey,
            child: const VehicleInsurance(),
            transitionDuration: const Duration(milliseconds: 400),
            reverseTransitionDuration: const Duration(milliseconds: 200),
          ),
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
        ),
        ShellRoute(
            navigatorKey: _shellkey,
            pageBuilder: (context, state, child) =>
                buildPageWithDefaultTransition(
                    context: context,
                    key: state.pageKey,
                    child: HomeScreen(child: child),
                    transitionDuration: const Duration(milliseconds: 800)),
            routes: [
              ShellRoute(
                  navigatorKey: _shellStatusKey,
                  parentNavigatorKey: _shellkey,
                  pageBuilder: (context, state, child) =>
                      buildPageWithSlideUpDownTransition(
                          context: context,
                          key: state.pageKey,
                          child: HomePanel(child: child),
                          transitionDuration:
                              const Duration(milliseconds: 400)),
                  routes: [
                    GoRoute(
                        parentNavigatorKey: _shellStatusKey,
                        name: HomeDashboard.name,
                        path: HomeDashboard.path,
                        pageBuilder: (context, state) =>
                            buildPageWithDefaultTransition(
                                context: context,
                                key: state.pageKey,
                                child: const HomeDashboard(),
                                transitionDuration:
                                    const Duration(milliseconds: 800)),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: _shellStatusKey,
                            name: HomeVehicle.name,
                            path: HomeVehicle.path,
                            pageBuilder: (context, state) =>
                                buildPageWithDefaultTransition(
                              context: context,
                              key: state.pageKey,
                              child: const HomeVehicle(),
                              transitionDuration:
                                  const Duration(milliseconds: 800),
                            ),
                          ),
                          GoRoute(
                              parentNavigatorKey: _shellStatusKey,
                              name: HomeWallet.name,
                              path: HomeWallet.path,
                              pageBuilder: (context, state) =>
                                  buildPageWithDefaultTransition(
                                    context: context,
                                    key: state.pageKey,
                                    child: const HomeWallet(),
                                    transitionDuration:
                                        const Duration(milliseconds: 800),
                                  ),
                              routes: [
                                GoRoute(
                                  parentNavigatorKey: _shellStatusKey,
                                  name: HomeIncome.name,
                                  path: HomeIncome.path,
                                  pageBuilder: (context, state) =>
                                      buildPageWithDefaultTransition(
                                          context: context,
                                          key: state.pageKey,
                                          child: const HomeIncome(),
                                          transitionDuration: const Duration(
                                              milliseconds: 800)),
                                ),
                              ]),
                        ]),
                  ]),
              ShellRoute(
                  navigatorKey: _shellRouteKey,
                  parentNavigatorKey: _shellkey,
                  pageBuilder: (context, state, child) =>
                      buildPageWithSlideUpDownTransition(
                          context: context,
                          key: state.pageKey,
                          child: RoutePanel(child: child),
                          transitionDuration:
                              const Duration(milliseconds: 800)),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _shellRouteKey,
                      name: RouteScreen.name,
                      path: RouteScreen.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        // context: context,
                        key: state.pageKey,
                        child: const RouteScreen(),
                        // transitionDuration: const Duration(milliseconds: 800)
                      ),
                    )
                  ]),
              ShellRoute(
                  navigatorKey: _shellDriverKey,
                  parentNavigatorKey: _shellkey,
                  pageBuilder: (context, state, child) =>
                      buildPageWithSlideUpDownTransition(
                          context: context,
                          key: state.pageKey,
                          child: DriverPanel(child: child),
                          transitionDuration:
                              const Duration(milliseconds: 800)),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _shellDriverKey,
                      name: CustomerRequest.name,
                      path: CustomerRequest.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        // context: context,
                        key: state.pageKey,
                        child: const CustomerRequest(),
                        // transitionDuration: const Duration(milliseconds: 800)
                      ),
                    ),
                    GoRoute(
                      parentNavigatorKey: _shellDriverKey,
                      name: CustomerRequestAccept.name,
                      path: CustomerRequestAccept.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        // context: context,
                        key: state.pageKey,
                        child: const CustomerRequestAccept(),
                        // transitionDuration: const Duration(milliseconds: 800)
                      ),
                    ),
                    GoRoute(
                      parentNavigatorKey: _shellDriverKey,
                      name: CustomerRequestComming.name,
                      path: CustomerRequestComming.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        // context: context,
                        key: state.pageKey,
                        child: const CustomerRequestComming(),
                        // transitionDuration: const Duration(milliseconds: 800)
                      ),
                    ),
                    GoRoute(
                      parentNavigatorKey: _shellDriverKey,
                      name: CustomerRequestReady.name,
                      path: CustomerRequestReady.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        // context: context,
                        key: state.pageKey,
                        child: const CustomerRequestReady(),
                        // transitionDuration: const Duration(milliseconds: 800)
                      ),
                    ),
                    GoRoute(
                      parentNavigatorKey: _shellDriverKey,
                      name: CustomerRequestGoing.name,
                      path: CustomerRequestGoing.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        // context: context,
                        key: state.pageKey,
                        child: const CustomerRequestGoing(),
                        // transitionDuration: const Duration(milliseconds: 800)
                      ),
                    ),
                  ])
            ])
      ],
    );
  },
);
