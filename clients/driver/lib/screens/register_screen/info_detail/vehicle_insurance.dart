import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/firebase/auth/google_sign_in.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/driver_insurance_provider.dart';
import 'package:driver/providers/status_provider.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/remind_info/remind_insurance_after.dart';
import 'package:driver/screens/register_screen/remind_info/remind_insurance_before.dart';
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

class VehicleInsurance extends ConsumerStatefulWidget {
  static const path = '/vehicle_insurance';
  static const name = 'vehicle_insurance';
  const VehicleInsurance({super.key});

  @override
  ConsumerState<VehicleInsurance> createState() => _VehicleInsuranceState();
}

class _VehicleInsuranceState extends ConsumerState<VehicleInsurance> {
  File? imageInsuranceFront;
  File? imageInsuranceBack;

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
    imageInsuranceFront =
        ref.watch(driverInsuranceProvider).imgDriverInsuranceFront;
    imageInsuranceBack =
        ref.watch(driverInsuranceProvider).imgDriverInsuranceBack;
    // print('idDriver');
    // print(imageBefore);
    // print(imageAfter);
    // print(licenseDateController.text);
    // print(selectedPlaceOfIssue);

    if (imageInsuranceFront != null && imageInsuranceBack != null) {
      setState(() {
        isLoading = true;
      });
      var dataImageBefore = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageInsuranceFront!.path)],
        'id': idDriver
      });

      var dataImageAfter = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageInsuranceBack!.path)],
        'id': idDriver
      });

      try {
        final dioClient = DioClient();

        final responseImgBefore = await dioClient.request(
          '/upload/vehicle-insurance-frontsight',
          options: Options(method: 'POST'),
          data: dataImageBefore,
        );

        final responseImgAfter = await dioClient.request(
          '/upload/vehicle-insurance-backsight',
          options: Options(method: 'POST'),
          data: dataImageAfter,
        );

        // print('API');
        // print(responseImgBefore.data);
        // print(responseImgAfter.data);

        if (responseImgBefore.statusCode == 200 &&
            responseImgAfter.statusCode == 200) {
          ref.read(statusProvider.notifier).setInsurance(true);
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

  handleSignOut() {
    GoogleSignInController.signOut().then((value) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.clear().then((value) {
          context.go(LoginScreen.path);
        });
      });
    });
  }

  openMenu() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return BottomMenu(
          height: (100.0 + (41.0 * 3)),
          label: const Text(
            'Hành động',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          widget: Column(
            children: [
              const Divider(
                height: 0.5,
                color: Colors.black12,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: handleSignOut,
                  child: const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.powerOff,
                        size: 18,
                        color: Color.fromARGB(255, 216, 62, 51),
                      ),
                      SizedBox(width: 13),
                      Text(
                        'Đăng xuất',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 216, 62, 51),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: WButton(
                  width: double.infinity,
                  radius: 50,
                  shadow: const BoxShadow(
                    color: Colors.transparent,
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black12,
                    backgroundColor: Colors.black12,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Đóng',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    imageInsuranceFront =
        ref.watch(driverInsuranceProvider).imgDriverInsuranceFront;
    imageInsuranceBack =
        ref.watch(driverInsuranceProvider).imgDriverInsuranceBack;

    print(imageInsuranceBack);
    print(imageInsuranceFront);
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
                                    child: imageInsuranceFront != null
                                        ? Image.file(imageInsuranceFront!)
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
                                    child: imageInsuranceBack != null
                                        ? Image.file(imageInsuranceBack!)
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
            // Navigator.pop(context);
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
