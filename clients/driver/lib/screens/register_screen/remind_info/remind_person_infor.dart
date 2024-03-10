import 'dart:io';

import 'package:driver/constants/colors.dart';
import 'package:driver/functions/pick_image.dart';
import 'package:driver/providers/driver_provider.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_bullet_point.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemindPersonImage extends ConsumerStatefulWidget {
  static const path = 'remind_person_image';
  static const name = 'remind_person_image';
  const RemindPersonImage({super.key});

  @override
  ConsumerState<RemindPersonImage> createState() => _RemindPersonImageState();
}

class _RemindPersonImageState extends ConsumerState<RemindPersonImage> {
  void _setImage(File image) {
    ref.read(driverProvider.notifier).setPersonImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(title: ''),
      body: GestureDetector(
        child: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  Row(
                    children: [
                      buildText(
                        'Hướng dẫn tải lên tài liệu',
                        kBlackColor,
                        18,
                        FontWeight.w600,
                        TextAlign.start,
                        TextOverflow.clip,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset(
                                    'assets/images/register/image_template1.jpg'),
                              ),
                              const SizedBox(
                                  width: 50), // Khoảng cách giữa hai ảnh
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset(
                                    'assets/images/register/image_template2.jpg'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                            child: Text('Tài liệu mẫu'),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(255, 160, 160, 160),
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: COLOR_DONE,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Yêu cầu',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildBulletPoint(
                                  'Ảnh nhận diện được chụp với phông nền trơn'),
                              const SizedBox(height: 8),
                              buildBulletPoint(
                                  'Ảnh nhận diện được chụp từ phần thân trên, rõ nét, không lóa sáng'),
                              const SizedBox(height: 8),
                              buildBulletPoint(
                                  'Ảnh nhận diện được chụp chính diện, nhìn thẳng, không nhắm mắt'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Hãy đảm bảo tài liệu KHÔNG',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildBulletPoint(
                                'Ảnh không được có thêm người, động vật hoặc các vật khác trong khung hình'),
                            const SizedBox(height: 8),
                            buildBulletPoint(
                                'Không đội mũ, không đeo khẩu trang, không đeo kính râm khi chụp ảnh'),
                            const SizedBox(height: 8),
                            buildBulletPoint('Không sử dụng ảnh thẻ'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: () async {
            await pickImage(context: context, setImage: _setImage);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kOrange),
          ),
          child: const Text(
            'Tải hồ sơ lên',
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
