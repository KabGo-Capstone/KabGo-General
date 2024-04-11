import 'package:customer/providers/stepProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationPickerWidget extends ConsumerWidget {
  const LocationPickerWidget({
    super.key,
    required this.heightIconPicker,
  });

  final double heightIconPicker;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: 175 + heightIconPicker / 2),
        child: Image.asset(
          ref.read(stepProvider) == 'departure_location_picker'
              ? 'lib/assets/images/map_departure_icon.png'
              : 'lib/assets/images/map_arrival_icon.png',
          height: heightIconPicker,
        ),
      ),
    );
  }
}