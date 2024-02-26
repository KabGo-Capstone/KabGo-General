import 'package:flutter/material.dart';

class SItem extends StatelessWidget {
  final String image;
  final String description;
  const SItem({super.key, required this.image, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.contain,
        ),
      ),
      child: SizedBox(
        width: 320,
        child: Text(
          description,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
