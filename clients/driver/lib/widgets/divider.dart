import 'package:flutter/material.dart';

class WDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double rounded;
  const WDivider(
      {super.key,
      this.height = 2,
      this.color = Colors.white,
      this.rounded = 100});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rounded),
          color: color,
        ),
      ),
    );
  }
}
