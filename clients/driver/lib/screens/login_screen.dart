import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/widgets/login_screen/footer/footer.dart';
import 'package:driver/widgets/login_screen/header/header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const path = '/login';
  static const name = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login/background.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              const LoginTitle(),
              const Spacer(flex: 4),
              LoginFooter(onRegisterPressed: () {
                Future.delayed(const Duration(milliseconds: 250), () {
                  context.pushNamed(RegisterScreen.name);
                });
              }),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
