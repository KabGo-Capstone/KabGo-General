import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/firebase/auth/google_sign_in.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/status_provider.dart';
import 'package:driver/providers/vehicle_image_provider.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/remind_info/remind_vehicle_back.dart';
import 'package:driver/screens/register_screen/remind_info/remind_vehicle_front.dart';
import 'package:driver/screens/register_screen/remind_info/remind_vehicle_left.dart';
import 'package:driver/screens/register_screen/remind_info/remind_vehicle_right.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/bottom_menu.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleInfo extends ConsumerStatefulWidget {
  static const path = '/vehicle_info';
  static const name = 'vehicle_info';
  const VehicleInfo({super.key});

  @override
  ConsumerState<VehicleInfo> createState() => _IVehicleInfoState();
}

class _IVehicleInfoState extends ConsumerState<VehicleInfo> {
  File? imageVehicleFront;
  File? imageVehicleBack;
  File? imageVehicleLeft;
  File? imageVehicleRight;

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
    imageVehicleFront = ref.watch(vehicleImageProvider).vehicleImageFront;
    imageVehicleBack = ref.watch(vehicleImageProvider).vehicleImageBack;
    imageVehicleLeft = ref.watch(vehicleImageProvider).vehicleImageLeft;
    imageVehicleRight = ref.watch(vehicleImageProvider).vehicleImageRight;
    // print('idDriver');
    // print(imageBefore);
    // print(imageAfter);
    // print(licenseDateController.text);
    // print(selectedPlaceOfIssue);

    if (imageVehicleFront != null &&
        imageVehicleBack != null &&
        imageVehicleLeft != null &&
        imageVehicleRight != null) {
      setState(() {
        isLoading = true;
      });

      var dataImageFront = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageVehicleFront!.path)],
        'id': idDriver
      });

      var dataImageBack = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageVehicleBack!.path)],
        'id': idDriver
      });

      var dataImageLeft = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageVehicleBack!.path)],
        'id': idDriver
      });

      var dataImageRight = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageVehicleBack!.path)],
        'id': idDriver
      });

      try {
        final dioClient = DioClient();

        final responseImgFront = await dioClient.request(
          '/upload/vehicle-img-frontsight',
          options: Options(method: 'POST'),
          data: dataImageFront,
        );

        final responseImgBack = await dioClient.request(
          '/upload/vehicle-img-backsight',
          options: Options(method: 'POST'),
          data: dataImageBack,
        );

        final responseImgLeft = await dioClient.request(
          '/upload/vehicle-img-leftsight',
          options: Options(method: 'POST'),
          data: dataImageLeft,
        );

        final responseImgRight = await dioClient.request(
          '/upload/vehicle-img-rightsight',
          options: Options(method: 'POST'),
          data: dataImageRight,
        );

        // print('API');
        // print(responseImgBefore.data);
        // print(responseImgAfter.data);

        if (responseImgFront.statusCode == 200 &&
            responseImgBack.statusCode == 200 &&
            responseImgRight.statusCode == 200 &&
            responseImgLeft.statusCode == 200) {
          ref.read(statusProvider.notifier).setImgVehicle(true);
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

  bool validateImages() {
    return imageVehicleFront != null && imageVehicleBack != null;
  }

  @override
  Widget build(BuildContext context) {
    imageVehicleFront = ref.watch(vehicleImageProvider).vehicleImageFront;
    imageVehicleBack = ref.watch(vehicleImageProvider).vehicleImageBack;
    imageVehicleLeft = ref.watch(vehicleImageProvider).vehicleImageLeft;
    imageVehicleRight = ref.watch(vehicleImageProvider).vehicleImageRight;

    return Scaffold(
      appBar: const AppBarCustom(),
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
                                    child: imageVehicleFront != null
                                        ? Image.file(imageVehicleFront!)
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
                                    builder: (context) =>
                                        const RemindVehicleBack(),
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
                                    child: imageVehicleBack != null
                                        ? Image.file(imageVehicleBack!)
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
                                    child: imageVehicleRight != null
                                        ? Image.file(imageVehicleRight!)
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
                                    builder: (context) =>
                                        const RemindVehicleLeft(),
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
                                    child: imageVehicleLeft != null
                                        ? Image.file(imageVehicleLeft!)
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
      // Trong phần bottomNavigationBar:
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: validateImages()
              ? () async {
                  handleRegister();
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
