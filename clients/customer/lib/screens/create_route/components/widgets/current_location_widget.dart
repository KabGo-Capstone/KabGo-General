import 'package:customer/providers/mapProvider.dart';
import 'package:customer/widgets/current_location_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentLocationWidget extends ConsumerWidget {
  const CurrentLocationWidget({
    super.key,
    required this.bottomPadding,
  });

  final double bottomPadding;

  @override
  Widget build(BuildContext context,ref) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 40),
      alignment: Alignment(0.92, 0.95 - bottomPadding * 2),
      child: CurrentLocationButton(getCurrentLocation: () {
        ref
            .read(mapProvider.notifier)
            .setMapAction('get_current_location');
      }),
    );
  }
}