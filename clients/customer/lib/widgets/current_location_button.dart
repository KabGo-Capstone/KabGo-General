import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({
    Key? key,
    required this.getCurrentLocation,
  }) : super(key: key);

  final void Function() getCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(120, 208, 208, 208),
            spreadRadius: 4,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      padding: EdgeInsets.zero,
      child: IconButton(
        onPressed: getCurrentLocation,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            shadowColor: const Color.fromARGB(120, 221, 221, 221)),
        icon: const FaIcon(
          FontAwesomeIcons.locationCrosshairs,
          color: Color(0xffEF773F),
          size: 24,
        ),
      ),
    );
  }
}
