import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/create_route/create_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapPicker extends ConsumerWidget {
  const MapPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        height: 170,
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Xin chào,',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 232, 223),
                      minimumSize: Size.zero, // Set this
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 9,
                      ),
                    ),
                    onPressed: () {
                      ref.read(stepProvider.notifier).setStep('arrival_location_picker');
                      ref.read(mapProvider.notifier).setMapAction('arrival_location_picker');
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 200),
                            pageBuilder: (context, animation, secondaryAnimation) => const CreateRoute(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1, 0);
                              const end = Offset(0, 0);

                              final tween = Tween(begin: begin, end: end);
                              return SlideTransition(
                                position: tween.animate(animation),
                                child: child,
                              );
                            },
                          ));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.mapLocationDot,
                      color: Colors.black,
                      size: 18,
                    ),
                    label: const Text(
                      'Bản đồ',
                      style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: const Text(
                    'Đinh Nguyễn Duy Khang',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/images/home_page_background.png',
                        // height: MediaQuery.of(context).size.width * 0.235,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
