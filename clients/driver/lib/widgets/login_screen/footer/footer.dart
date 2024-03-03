import 'package:driver/widgets/button.dart';
import 'package:flutter/material.dart';

typedef OnRegisterPressed = void Function();

class LoginFooter extends StatelessWidget {
  final OnRegisterPressed onRegisterPressed;
  const LoginFooter({super.key, required this.onRegisterPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'THAM GIA NGAY VỚI CHÚNG TÔI',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        WButton(
          width: 340,
          radius: 50,
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 156, 156, 156),
            backgroundColor: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0,
            alignment: Alignment.center,
          ),
          icon: const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16, right: 6, left: 0),
            child: Image(
              image: AssetImage('assets/images/login/google.png'),
              width: 26,
              height: 26,
            ),
          ),
          label: const Text(
            'Tiếp tục với tài khoản Google',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xFF7A7A7A),
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: onRegisterPressed,
        ),
      ],
    );
  }
}
