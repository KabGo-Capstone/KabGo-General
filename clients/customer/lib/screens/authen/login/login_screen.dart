import 'package:customer/screens/authen/login/widget/login_item.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {'title': 'Tiếp tục với FaceBook', 'icon': 'lib/assets/images/facebook_logo.png', 'key': 'authen_facebook'},
      {'title': 'Tiếp tục với Google', 'icon': 'lib/assets/images/google_logo.png', 'key': 'authen_google'},
      {'title': 'Tiếp tục với Apple', 'icon': 'lib/assets/images/apple_logo.png', 'key': 'authen_apple'},
    ];

    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: const Color(0xffEF773F).withOpacity(0.9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "KabGO",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            Text(
              "Siêu ứng dụng đặt xe hàng đầu \nViệt Nam",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ListView.separated(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return LoginItem(item: data[index]);
              }),
              separatorBuilder: ((context, index) {
                return const SizedBox(
                  height: 20,
                );
              }),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Colors.white,
                    height: 2,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Hoặc",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Divider(
                    color: Colors.white,
                    height: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const LoginItem(
              item: {
                'title': 'Tiếp tục với số điện thoại',
                'icon': 'lib/assets/images/phone_logo.png',
                'key': 'authen_phone'
              },
            ),
          ],
        ),
      ),
    );
  }
}
