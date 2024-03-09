import 'dart:io';

import 'package:driver/constants/colors.dart';
import 'package:driver/screens/register_screen/remind_info/remind_vehicle_back.dart';
import 'package:driver/screens/register_screen/remind_info/remind_vehicle_front.dart';
import 'package:driver/screens/register_screen/remind_info/remind_vehicle_left.dart';
import 'package:driver/screens/register_screen/remind_info/remind_vehicle_right.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({super.key});

  @override
  State<VehicleInfo> createState() => _IVehicleInfoState();
}

class _IVehicleInfoState extends State<VehicleInfo> {
  TextEditingController licenseDate = TextEditingController();
  TextEditingController licenseDateController = TextEditingController();
  File? _image1;
  File? _image2;
  File? _image3;
  File? _image4;
  String? selectedPlaceOfIssue;

  bool validateImages() {
    return _image1 != null && _image2 != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: ''),
      backgroundColor: kWhiteColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/register/person_info.png',
                        height: 160,
                      ),
                    ),
                  ],
                ),
                buildText(
                  'Hình ảnh xe',
                  kBlackColor,
                  18,
                  FontWeight.w600,
                  TextAlign.start,
                  TextOverflow.clip,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'Mặt trước chính diện xe',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RemindVehicleFront(),
                              ),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              width: 100,
                              height: 75,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Màu nền
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: _image1 != null
                                    ? Image.file(_image1!)
                                    : const SizedBox(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                size: 30,
                                                color: COLOR_GRAY,
                                              ),
                                              Text(
                                                'Tải ảnh lên',
                                                style: TextStyle(fontSize: 11),
                                              )
                                            ]),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'Mặt sau xe ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RemindVehicleBack(),
                              ),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              width: 100,
                              height: 75,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Màu nền
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: _image2 != null
                                    ? Image.file(_image2!)
                                    : const SizedBox(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                size: 30,
                                                color: COLOR_GRAY,
                                              ),
                                              Text(
                                                'Tải ảnh lên',
                                                style: TextStyle(fontSize: 11),
                                              )
                                            ]),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'Mặt hông xe (Bên phải) ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RemindVehicleRight(),
                              ),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              width: 100,
                              height: 75,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Màu nền
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: _image3 != null
                                    ? Image.file(_image3!)
                                    : const SizedBox(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                size: 30,
                                                color: COLOR_GRAY,
                                              ),
                                              Text(
                                                'Tải ảnh lên',
                                                style: TextStyle(fontSize: 11),
                                              )
                                            ]),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'Mặt hông xe (Bên trái) ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RemindVehicleLeft(),
                              ),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              width: 100,
                              height: 75,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Màu nền
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: _image4 != null
                                    ? Image.file(_image4!)
                                    : const SizedBox(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                size: 30,
                                                color: COLOR_GRAY,
                                              ),
                                              Text(
                                                'Tải ảnh lên',
                                                style: TextStyle(fontSize: 11),
                                              )
                                            ]),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // Trong phần bottomNavigationBar:
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: validateImages()
              ? () async {
                  Navigator.pop(context);
                }
              : null,
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
