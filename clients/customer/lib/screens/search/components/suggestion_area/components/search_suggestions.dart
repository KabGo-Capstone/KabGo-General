// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/create_route/create_route.dart';
import 'package:customer/widgets/suggestiion_arrival_item.dart';
import 'package:flutter/material.dart';

import 'package:customer/models/location_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchSuggestions extends ConsumerWidget {
  const SearchSuggestions({
    Key? key,
    required this.suggestionLocationList,
  }) : super(key: key);
  final List<LocationModel> suggestionLocationList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return suggestionLocationList.isNotEmpty
        ? Column(
            children: [
              ...suggestionLocationList.map((e) {
                e.structuredFormatting!.formatSecondaryText();
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(arrivalLocationProvider.notifier)
                        .setArrivalLocation(e);
                    ref
                        .read(stepProvider.notifier)
                        .setStep('departure_location_picker');
                    ref
                        .read(mapProvider.notifier)
                        .setMapAction('departure_location_picker');
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const CreateRoute(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                  child: e.structuredFormatting!.secondaryText!
                          .contains('TP.Hồ Chí Minh')
                      ? SuggestiionArrivalItem(
                          data: e,
                        )
                      : const SizedBox(),
                );
              })
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Không tìm thấy',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          );
  }
}
