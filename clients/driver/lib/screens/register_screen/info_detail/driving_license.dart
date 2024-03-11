import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/driving_license.dart';
import 'package:driver/screens/register_screen/remind_info/remind_license_after.dart';
import 'package:driver/screens/register_screen/remind_info/remind_license_before.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DivingLicense extends ConsumerStatefulWidget {
  const DivingLicense({super.key});

  @override
  ConsumerState<DivingLicense> createState() => _DivingLicenseState();
}

class _DivingLicenseState extends ConsumerState<DivingLicense> {
  File? imageDrivingLicenseBefore;
  File? imageDrivingLicenseAfter;
  String? selectedPlaceOfIssue;
  late String? idDriver;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleRegister() async {
    idDriver = ref.watch(driverInfoRegisterProvider).id ?? '6';
    imageDrivingLicenseBefore =
        ref.watch(drivingLicenseProvider).imgDrivingLicenseBefore;
    imageDrivingLicenseAfter =
        ref.watch(drivingLicenseProvider).imgDrivingLicenseAfter;
    // print('idDriver');
    // print(imageBefore);
    // print(imageAfter);
    // print(licenseDateController.text);
    // print(selectedPlaceOfIssue);

    if (imageDrivingLicenseBefore != null && imageDrivingLicenseAfter != null) {
      setState(() {
        isLoading = true;
      });
      var dataImageBefore = FormData.fromMap({
        'image': [
          await MultipartFile.fromFile(imageDrivingLicenseBefore!.path)
        ],
        'id': idDriver
      });

      var dataImageAfter = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageDrivingLicenseAfter!.path)],
        'id': idDriver
      });

      try {
        final dioClient = DioClient();

        final responseImgBefore = await dioClient.request(
          '/upload/driver-license-frontsight',
          options: Options(method: 'POST'),
          data: dataImageBefore,
        );

        final responseImgAfter = await dioClient.request(
          '/upload/driver-license-backsight',
          options: Options(method: 'POST'),
          data: dataImageAfter,
        );

        // print('API');
        // print(responseImgBefore.data);
        // print(responseImgAfter.data);

        if (responseImgBefore.statusCode == 200 &&
            responseImgAfter.statusCode == 200) {
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        } else {
          // Handle error
        }
      } catch (e) {
        // Handle error
      }
    } else {
      print('Image is null!');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('DivingLicense rebuild');
    imageDrivingLicenseBefore =
        ref.watch(drivingLicenseProvider).imgDrivingLicenseBefore;
    imageDrivingLicenseAfter =
        ref.watch(drivingLicenseProvider).imgDrivingLicenseAfter;
    return Scaffold(
      appBar: const AppBarCustom(title: ''),
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          GestureDetector(
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
                      'Bằng lái xe',
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
                                        const RemindDivingLicenseBefore(),
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
                                    child: imageDrivingLicenseBefore != null
                                        ? Image.file(imageDrivingLicenseBefore!)
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
                                                    style:
                                                        TextStyle(fontSize: 11),
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
                                        const RemindDivingLicenseAfter(),
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
                                    child: imageDrivingLicenseAfter != null
                                        ? Image.file(imageDrivingLicenseAfter!)
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
                                                    style:
                                                        TextStyle(fontSize: 11),
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
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: () async {
            handleRegister();
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
