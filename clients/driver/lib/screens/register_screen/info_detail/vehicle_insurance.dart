import 'dart:io';

import 'package:driver/constants/colors.dart';
import 'package:driver/screens/register_screen/remind_info/remind_insurance_after.dart';
import 'package:driver/screens/register_screen/remind_info/remind_insurance_before.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';

class VehicleInsurance extends StatefulWidget {
  const VehicleInsurance({super.key});

  @override
  State<VehicleInsurance> createState() => _VehicleInsuranceState();
}

class _VehicleInsuranceState extends State<VehicleInsurance> {
  File? _image;
  String? selectedPlaceOfIssue;

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
                        'assets/images/register/diving_license.png',
                        height: 160,
                      ),
                    ),
                  ],
                ),
                buildText(
                  'Bảo hiểm xe',
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
                            text: 'Mặt trước ',
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
                                    const RemindInsuranceBefore(),
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
                                child: _image != null
                                    ? Image.file(_image!)
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
                            text: 'Mặt sau ',
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
                                    const RemindInsuranceAfter(),
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
                                child: _image != null
                                    ? Image.file(_image!)
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
