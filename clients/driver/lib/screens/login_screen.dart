import 'package:driver/configs/router.dart';
import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/widgets/login_screen/carousel/carousel.dart';
import 'package:driver/widgets/login_screen/footer/footer.dart';
import 'package:driver/widgets/login_screen/header/header.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const path = '/login';
  static const name = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.top),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              if (screenHeight >= 720) const LoginHeader(),
              const Carousel(),
              if (screenHeight < 880) const Spacer(),
              if (screenHeight >= 880) const SizedBox(height: 30),
              LoginFooter(
                onRegisterPressed: () {
                  // Chuyển sang trang đăng ký khi nút được nhấn
                  router.push(RegisterScreen.path);
                },
              ),
              if (screenHeight >= 880) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
