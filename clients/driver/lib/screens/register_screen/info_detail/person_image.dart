import 'dart:io';

import 'package:driver/constants/colors.dart';
import 'package:flutter/material.dart';

class PersonImage extends StatefulWidget {
  const PersonImage({super.key});

  @override
  State<PersonImage> createState() => _PersonImageState();
}

class _PersonImageState extends State<PersonImage> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Text(
                    'Cập nhật hình nền trên ứng dụng. ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Bắt buộc!',
                    style:
                        TextStyle(color: kOrange, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 64,
                      foregroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: const Text(
                        'Ảnh',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () async {},
                    child: const Text('Chọn 1 ảnh'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
