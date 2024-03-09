import 'dart:io';

import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/currentLocationProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/search/search.dart';
import 'package:customer/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArrivalLocationPicker extends ConsumerStatefulWidget {
  const ArrivalLocationPicker({Key? key}) : super(key: key);

  @override
  _ArrivalLocationPickerState createState() => _ArrivalLocationPickerState();
}

class _ArrivalLocationPickerState extends ConsumerState<ArrivalLocationPicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocationModel locationPicker = ref.watch(arrivalLocationProvider);
    if (locationPicker.structuredFormatting == null) {
      locationPicker = ref.read(currentLocationProvider);
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
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
            'Chọn điểm đến',
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
              child: Row(
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
                      color: Color(0xffED6C66),
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
                        Text(locationPicker.structuredFormatting!.mainText!,
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
                            style: Theme.of(context).textTheme.displaySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          BottomButton(
              backButton: () {
                ref.read(stepProvider.notifier).setStep('default');
                ref
                    .read(arrivalLocationProvider.notifier)
                    .setArrivalLocation(LocationModel());
                Navigator.pop(context);
              },
              nextButton: () {
                ref
                    .read(stepProvider.notifier)
                    .setStep('departure_location_picker');
                ref
                    .read(mapProvider.notifier)
                    .setMapAction('departure_location_picker');
              },
              nextButtonText: 'Chọn điểm đón này',
              opacity: true),
        ],
      ),
    );
  }
}
