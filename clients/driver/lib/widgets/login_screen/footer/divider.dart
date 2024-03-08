import 'package:driver/widgets/divider.dart';
import 'package:flutter/material.dart';

class LoginFooterDivider extends StatelessWidget {
  const LoginFooterDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        WDivider(),
        SizedBox(width: 16),
        Text(
          'Sign up or log in with',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16),
        WDivider(),
      ],
    );
  }
}
