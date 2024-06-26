import 'package:driver/widgets/google_map/google_map.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> acceptPath400 = [
    '/',
    '/wallet',
    '/wallet/income',
    '/customer/request',
    '/customer/request/accept'
  ];
  final List<String> acceptPath300 = [
    '/customer/request/comming',
    '/customer/request/going'
  ];
  final List<String> acceptPath100 = ['/route'];
  final List<String> acceptPath700 = ['/customer/request/ready'];

  @override
  Widget build(BuildContext context) {
    String? currentLocation = GoRouterState.of(context).fullPath!;

    double panelHeight = 400;

    if (acceptPath400.contains(currentLocation)) {
      panelHeight = 400;
    } else if (acceptPath300.contains(currentLocation)) {
      panelHeight = 300;
    } else if (acceptPath100.contains(currentLocation)) {
      panelHeight = 100;
    } else if (acceptPath700.contains(currentLocation)) {
      panelHeight = 700;
    } else {
      panelHeight = 500;
    }

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.only(bottom: (panelHeight - 100)),
              child: const KGoogleMap()),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: panelHeight,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: widget.child),
          ),
        ],
      ),
    ));
  }
}
