import 'package:driver/constants/colors.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: COLOR_WHITE,
      actions: [
        OutlinedButton(
          onPressed: () {
            print('Cần hỗ trợ');
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(0, 0)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
            side: MaterialStateProperty.all(const BorderSide(
                color: Color.fromARGB(255, 97, 97, 97), width: 0.7)),
          ),
          child: const Text(
            'Cần hỗ trợ?',
            style: TextStyle(color: Colors.black),
          ),
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'message',
                child: Row(
                  children: [
                    Icon(Icons.message),
                    SizedBox(width: 10),
                    Text('Nhắn tin'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: kRed,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Đăng xuất',
                      style: TextStyle(color: kRed),
                    ),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
