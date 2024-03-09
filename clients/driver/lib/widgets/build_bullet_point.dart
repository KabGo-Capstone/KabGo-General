import 'package:flutter/material.dart';

Widget buildBulletPoint(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '• ',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
      ),
      Expanded(
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}
