import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteInformationWidget extends ConsumerWidget {
  const RouteInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LatLng departure = ref.read(departureLocationProvider).postion!;

    print('Depare Location: ${departure.latitude} ${departure.longitude}');

    return Positioned(
      top: MediaQuery.of(context).size.height * 0.08,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(80, 220, 220, 220),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidCircleDot,
                          size: 16,
                          color: Color(0xff006FD5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            ref
                                .read(departureLocationProvider)
                                .structuredFormatting!
                                .mainText!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(27, 8, 0, 8),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color.fromARGB(255, 225, 225, 225),
                      ),
                    ),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidCircleDot,
                          size: 16,
                          color: Color(0xffFA4848),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            ref
                                .read(arrivalLocationProvider)
                                .structuredFormatting!
                                .mainText!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 225, 225, 225))),
                child: const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.circlePlus,
                      color: Color(0xffFA4848),
                      size: 18,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Thêm',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
