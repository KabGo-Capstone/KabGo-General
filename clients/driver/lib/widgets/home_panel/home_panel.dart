import 'dart:convert';

import 'package:driver/models/location.dart';
import 'package:driver/providers/customer_request.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/request_status.dart';
import 'package:driver/providers/socket_provider.dart';
import 'package:driver/screens/customer_request/customer_request.dart';
import 'package:driver/widgets/icon_button/icon_button.dart';
import 'package:driver/widgets/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

import 'package:driver/models/driver.dart';
import 'package:driver/models/vehicle.dart';
import 'package:driver/providers/current_location.dart';
import 'package:driver/providers/driver_details_provider.dart';
import 'package:driver/widgets/home_panel/styles.dart';

class HomePanel extends ConsumerStatefulWidget {
  const HomePanel({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<HomePanel> createState() => _HomePanelState();
}

class _HomePanelState extends ConsumerState<HomePanel> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketNotifier = ref.read(socketClientProvider.notifier);
    final bool active = ref.watch(socketClientProvider);
    
    final driverInfoNotifier =
                            ref.read(driverInfoRegisterProvider);

    final currentLocation = ref.read(currentLocationProvider);
    final requestState = ref.read(requestStatusProvider);

    if (requestState == RequestStatus.waiting) {
      final customerRequest = ref.watch(customerRequestProvider);

      if (customerRequest.hasValue()) {
        Future.delayed(Duration.zero, () {
          if (active == true) {
            WidgetsFlutterBinding.ensureInitialized();
            context.go(CustomerRequest.path);
          }
        });
      }
    }

    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CIconButton(
                      onPressed: () {
                        // context.go(HomeVehicle.path);
                      },
                      icon: Transform.rotate(
                          angle: 180 * math.pi / 180,
                          child: const Icon(FontAwesomeIcons.sliders,
                              color: Color(0xFF6A6A6A))),
                      padding: const EdgeInsets.all(10),
                      foregroundColor: const Color(0xFF6A6A6A)),
                  Expanded(
                      child: Text(active ? 'Đang hoạt động' : 'Không hoạt động',
                          style: active
                              ? ThemeText.statusActiveText
                              : ThemeText.statusText,
                          textAlign: TextAlign.center)),
                  CIconButton(
                    onPressed: () {
                      socketNotifier.toggle();
                      socketNotifier.publish(
                          'join-server',
                          jsonEncode(Driver(
                            driverId: driverInfoNotifier.id!,
                            driver: DriverInfo(
                                firstname: driverInfoNotifier.firstName!,
                                lastname: driverInfoNotifier.lastName!,
                                avatar: driverInfoNotifier.avatar!,
                                phonenumber: driverInfoNotifier.phoneNumber!),
                            service: driverInfoNotifier.serviceName!,
                            status: 'FREE',
                            vehicle: Vehicle(
                                name: 'Honda Wave RSX',
                                identity_number: '68S164889',
                                color: 'Đen',
                                brand: 'Honda'),
                            position: LocationPostion(
                              lat: currentLocation.latitude,
                              lng: currentLocation.longitude,
                            ),
                          ).toJson()));
                    },
                    icon: Icon(FontAwesomeIcons.powerOff,
                        color: active == true
                            ? const Color(0xFFF86C1D)
                            : const Color(0xFF6A6A6A),
                        size: 19),
                    padding: const EdgeInsets.all(12),
                    borderSide: BorderSide(
                      color: active == true
                          ? const Color(0xFFFFB393)
                          : const Color(0xFFEDEDED),
                      width: 1,
                    ),
                    backgroundColor: active == true
                        ? const Color(0xFFFFF4EF)
                        : const Color(0xFFEDEDED),
                    foregroundColor: active == true
                        ? const Color(0xFFFFF4EF)
                        : const Color(0xFF6A6A6A),
                    elevation: 0,
                  ),
                ],
              ),
            ),
            Expanded(child: widget.child),
            CNavigation(initialSelection: 'Trang chủ', items: [
              CNavigationItem(
                onPressed: () {
                  context.go('/');
                },
                // shape: const ContinuousRectangleBorder(),
                padding: const EdgeInsets.all(16),
                gap: 9,
                icon: const Icon(FontAwesomeIcons.house, size: 20),
                label: 'Trang chủ',
                textColor: const Color(0xFF6A6A6A),
                foregroundColor: const Color(0xFF6A6A6A),
                activeColor: const Color(0xFFF86C1D),
                canGo: !active,
              ),
              CNavigationItem(
                onPressed: () {
                  context.go('/wallet');
                },
                // shape: const ContinuousRectangleBorder(),
                padding: const EdgeInsets.all(21),
                gap: 9,
                icon: const Icon(FontAwesomeIcons.wallet, size: 20),
                label: 'Ví tiền',
                textColor: const Color(0xFF6A6A6A),
                foregroundColor: const Color(0xFF6A6A6A),
                activeColor: const Color(0xFFF86C1D),
                canGo: !active,
              ),
              CNavigationItem(
                onPressed: () {
                  context.go('/wallet/income');
                },
                // shape: const ContinuousRectangleBorder(),
                padding: const EdgeInsets.all(16),
                gap: 9,
                icon: const Icon(FontAwesomeIcons.chartSimple, size: 20),
                label: 'Thu nhập',
                textColor: const Color(0xFF6A6A6A),
                foregroundColor: const Color(0xFF6A6A6A),
                activeColor: const Color(0xFFF86C1D),
                canGo: !active,
              ),
              CNavigationItem(
                onPressed: () {},
                // shape: const ContinuousRectangleBorder(),
                padding: const EdgeInsets.all(16),
                gap: 7,
                icon: const Icon(Icons.widgets, size: 24),
                label: 'Xem thêm',
                textColor: const Color(0xFF6A6A6A),
                foregroundColor: const Color(0xFF6A6A6A),
                activeColor: const Color(0xFFF86C1D),
                canGo: !active,
              ),
            ]),
          ],
        ));
  }
}
