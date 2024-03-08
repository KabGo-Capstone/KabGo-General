import 'package:driver/widgets/button.dart';
import 'package:driver/widgets/login_screen/footer/divider.dart';
import 'package:flutter/material.dart';

typedef OnRegisterPressed = void Function();

class LoginFooter extends StatelessWidget {
  final OnRegisterPressed onRegisterPressed;
  const LoginFooter({super.key, required this.onRegisterPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LoginFooterDivider(),
        const SizedBox(
          height: 12,
        ),
        WButton(
          width: double.infinity,
          radius: 50,
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 63, 63, 63),
            backgroundColor: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0,
            alignment: Alignment.center,
          ),
          icon: const Image(
            image: AssetImage('assets/images/login/google.png'),
            width: 20,
            height: 20,
          ),
          label: const Text(
            'Google',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF4E4E4E),
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: onRegisterPressed,
        ),
      ],
    );
  }
}
