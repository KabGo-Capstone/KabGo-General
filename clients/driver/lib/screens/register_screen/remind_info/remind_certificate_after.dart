import 'dart:io';

import 'package:driver/constants/colors.dart';
import 'package:driver/functions/pick_image.dart';
import 'package:driver/providers/vehicle_register_provider.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_bullet_point.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RemindCertificateAfter extends ConsumerStatefulWidget {
  static const path = 'remind_person_image';
  static const name = 'remind_person_image';
  const RemindCertificateAfter({super.key});

  @override
  ConsumerState<RemindCertificateAfter> createState() =>
      _RemindCertificateAfterState();
}

class _RemindCertificateAfterState
    extends ConsumerState<RemindCertificateAfter> {
  void _setImage(File image) {
    ref
        .read(vehicleRegisterNotifier.notifier)
        .setVehicleRegisterImageBack(image);
    // setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(),
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.asset(
                                    'assets/images/register/certificate_af1.JPG'),
                              ),
                              const SizedBox(
                                  width: 20), // Khoảng cách giữa hai ảnh
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.asset(
                                    'assets/images/register/certificate_af2.JPG'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
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
                                  'Chỉ nhận hình ảnh bản gốc, không chấp nhận giấy Cavet/Đăng ký xe'),
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
                                'Giấy tờ chụp đầy đủ thông tin, không mất góc'),
                            const SizedBox(height: 8),
                            buildBulletPoint(
                                'Hình ảnh không được chụp quá tầm mắt nhìn'),
                            const SizedBox(height: 8),
                            buildBulletPoint(
                                'Không chụp ảnh qua màn hình hoặc sử dụng giấy tờ scan. Ảnh chụp rõ nét, không lóa sáng, không can thiệp chỉnh sửa'),
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
