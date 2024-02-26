import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double aspectRatio = (MediaQuery.of(context).size.height) / MediaQuery.of(context).size.width;

    return Column(
      children: [
        if (MediaQuery.of(context).size.height >= 820)
          AspectRatio(
            aspectRatio: 1 / (aspectRatio * 0.12),
            child: Image.asset(
              'assets/logo-only.png',
              fit: BoxFit.contain,
            ),
          ),
        const SizedBox(
          height: 18,
        ),
        Text(
          'KabGo Driver',
          style: TextStyle(
            fontSize: 28,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Nâng tầm trải nghiệm \nMở rộng cơ hội tìm kiếm thu nhập',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
