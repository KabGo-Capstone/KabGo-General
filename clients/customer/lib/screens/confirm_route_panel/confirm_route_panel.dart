import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:customer/functions/convertTimeFormat.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/models/route_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/routeProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/widgets/bottom_button.dart';

class ConfirmRoutePanel extends ConsumerStatefulWidget {
  const ConfirmRoutePanel({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConfirmRoutePanel> createState() => _ConfirmRouteDialogState();
}

class _ConfirmRouteDialogState extends ConsumerState<ConfirmRoutePanel> {
  @override
  Widget build(BuildContext context) {
    print('===========> CONFIRM_ROUTE_PANEL BUILD');

    RouteModel routeModal = ref.watch(routeProvider);

    String travelTime = routeModal.time ?? '0';
    String distance = routeModal.distance ?? '0.0';
    LocationModel departure = ref.read(departureLocationProvider);
    LocationModel arrival = ref.read(arrivalLocationProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
      // height: 300,
      width: MediaQuery.of(context).size.width,
      height: 400,
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ///////////////////////////////////////////////////// LOCATION INPUT
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Lộ trình của bạn',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/trip_icon.png',
                height: 120,
              ),
              const SizedBox(
                width: 13,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF9F9F9),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffF2F2F2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(departure.structuredFormatting!.mainText!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              '${departure.structuredFormatting!.mainText!}, ${(departure.structuredFormatting!.secondaryText!)}',
                              style: Theme.of(context).textTheme.displaySmall),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF9F9F9),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffF2F2F2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            arrival.structuredFormatting!.mainText!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${arrival.structuredFormatting!.mainText!}, ${(arrival.structuredFormatting!.secondaryText!)}',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidMap,
                    color: Color(0xffFE8248),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    distance,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidClock,
                    color: Color(0xffA6A6A6),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    convertTimeFormat(travelTime),
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffA6A6A6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          BottomButton(
            opacity: true,

              backButton: () {
                ref.read(stepProvider.notifier).setStep('choose_departure');
                ref
                    .read(mapProvider.notifier)
                    .setMapAction('GET_NEW_DEPARTURE_LOCATION');
              },
              nextButton: () {
                ref.read(stepProvider.notifier).setStep('create_trip');
                ref.read(mapProvider.notifier).setMapAction('CREATE_TRIP');
              },
              nextButtonText: 'xác nhận'),
        ],
      ),
    );
  }
}
