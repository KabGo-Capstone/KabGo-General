import 'dart:io';

import 'package:driver/constants/colors.dart';
import 'package:driver/screens/register_screen/remind_info/remind_person_infor.dart';
import 'package:driver/widgets/app_bar.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(title: ''),
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
              Row(
                children: [
                  Image.asset(
                    'assets/images/register/info_v1.png',
                    width: screenWidth *
                        0.8, // Đặt chiều rộng của ảnh là 80% chiều rộng màn hình
                  ),
                ],
              ),
              const Center(
                  child: Text(
                'Xin chào Vinh!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 64,
                      foregroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(
                              Icons.picture_in_picture_sharp,
                              size: 50,
                              color: COLOR_GRAY,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // await pickImage(context: context, setImage: _setImage);
                      // context.pushNamed('remind_person_image');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RemindPersonImage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Tải ảnh lên',
                      style: TextStyle(color: COLOR_TEXT_MAIN),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kOrange),
          ),
          child: const Text(
            'Lưu',
            style: TextStyle(
              fontSize: 16,
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
