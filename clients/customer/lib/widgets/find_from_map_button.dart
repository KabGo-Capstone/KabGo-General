import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FindFromMapButton extends StatefulWidget {
  const FindFromMapButton({Key? key, required this.keyboardAppearance, required this.press}) : super(key: key);
  final bool keyboardAppearance;
  final VoidCallback press;

  @override
  State<FindFromMapButton> createState() => _FindFromMapState();
}

class _FindFromMapState extends State<FindFromMapButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        padding: EdgeInsets.only(
            bottom: widget.keyboardAppearance
                ? 10
                : Platform.isIOS
                    ? 40
                    : 20,
            top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 216, 216, 216).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.mapLocationDot,
              color: Colors.black,
              size: 16,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Chọn từ bản đồ',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
