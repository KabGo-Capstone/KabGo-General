import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/driver_insurance_provider.dart';
import 'package:driver/screens/register_screen/remind_info/remind_insurance_after.dart';
import 'package:driver/screens/register_screen/remind_info/remind_insurance_before.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleInsurance extends ConsumerStatefulWidget {
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
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          // Navigator.pop(context);
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
    imageInsuranceFront =
        ref.watch(driverInsuranceProvider).imgDriverInsuranceFront;
    imageInsuranceBack =
        ref.watch(driverInsuranceProvider).imgDriverInsuranceBack;

    print(imageInsuranceBack);
    print(imageInsuranceFront);
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
