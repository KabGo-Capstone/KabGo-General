import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0xffFE8248),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Thông tin tài khoản',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
