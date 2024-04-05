import 'dart:io';

import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/currentLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/search/search.dart';
import 'package:customer/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DepartureLocationPicker extends ConsumerStatefulWidget {
  const DepartureLocationPicker({Key? key}) : super(key: key);

  @override
  _DepartureLocationPickerState createState() =>
      _DepartureLocationPickerState();
}

class _DepartureLocationPickerState
    extends ConsumerState<DepartureLocationPicker> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    LocationModel locationPicker = ref.watch(departureLocationProvider);
    LocationModel currentLocation = ref.watch(currentLocationProvider);

    if (locationPicker.placeId == null && currentLocation.placeId != null) {
      locationPicker = currentLocation;
      loading = false;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15, 15, 15, Platform.isIOS ? 40 : 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(58, 166, 166, 166),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, -3),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chọn điểm đón',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const Search(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0, 1);
                      const end = Offset(0, 0);

                      final tween = Tween(begin: begin, end: end);
                      return SlideTransition(
                        position: tween.animate(animation),
                        child: child,
                      );
                    },
                  ));
            },
            child: Container(
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
              child: loading
                  ? const Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          color: Color(0xffFE8248),
                          strokeWidth: 4,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.solidCircleDot,
                            size: 16,
                            color: Color(0xff4F96FF),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  locationPicker
                                      .structuredFormatting!.mainText!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '${locationPicker.structuredFormatting!.mainText!}, ${(locationPicker.structuredFormatting!.secondaryText!)}',
                                  maxLines: 2,
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 15,
              ),
              FaIcon(
                FontAwesomeIcons.solidPenToSquare,
                size: 18,
                color: Color(0xffF86C1D),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Thêm ghi chú về điểm đón cho tài xế',
                style: TextStyle(
                    color: Color(0xffF86C1D),
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          const Spacer(),
          BottomButton(
              backButton: () {
                ref.read(stepProvider.notifier).setStep('default');
                ref
                    .read(departureLocationProvider.notifier)
                    .setDepartureLocation(LocationModel());
                ref
                    .read(arrivalLocationProvider.notifier)
                    .setArrivalLocation(LocationModel());

                Navigator.pop(context);
              },
              nextButton: () {
                ref.read(mapProvider.notifier).setMapAction('draw_route');
                ref.read(stepProvider.notifier).setStep('create_trip');
              },
              nextButtonText: 'Chọn điểm đón này',
              opacity: !loading),
        ],
      ),
    );
  }
}
