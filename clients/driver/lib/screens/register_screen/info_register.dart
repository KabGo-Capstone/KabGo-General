import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/firebase/auth/google_sign_in.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/status_provider.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/info_detail/driving_license.dart';
import 'package:driver/screens/register_screen/info_detail/driving_register.dart';
import 'package:driver/screens/register_screen/info_detail/emergency_contact.dart';
import 'package:driver/screens/register_screen/info_detail/id_person.dart';
import 'package:driver/screens/register_screen/info_detail/person_image.dart';
import 'package:driver/screens/register_screen/info_detail/vehicle_info.dart';
import 'package:driver/screens/register_screen/info_detail/vehicle_insurance.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/bottom_menu.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/button.dart';
import 'package:driver/widgets/item_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoRegister extends ConsumerStatefulWidget {
  static const path = '/info_register';
  static const name = 'info';
  const InfoRegister({super.key});

  @override
  ConsumerState<InfoRegister> createState() => _InfoRegisterState();
}

class _InfoRegisterState extends ConsumerState<InfoRegister> {
  @override
  Widget build(BuildContext context) {
    final status = ref.watch(statusProvider);

    final isCompletedAll = status.isCompletedEmergency &&
        status.isCompletedID &&
        status.isCompletedImgPerson &&
        status.isCompletedImgVehicle &&
        status.isCompletedInsurance &&
        status.isCompletedLicense &&
        status.isCompletedRegisterVehicle;

    handleRegister() async {
      final idDriver = ref.watch(driverInfoRegisterProvider).id;

      var data = json.encode({
        'id': idDriver,
      });

      try {
        final dioClient = DioClient();

        final responseImgBefore = await dioClient.request(
          '/submit-driver',
          options: Options(method: 'POST'),
          data: data,
        );

        if (responseImgBefore.statusCode == 200) {
          ref.read(statusProvider.notifier).setInsurance(true);
        }
      } catch (e) {
        // Handle error
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildText(
                              'Gửi tài liệu',
                              kBlackColor,
                              18,
                              FontWeight.w600,
                              TextAlign.start,
                              TextOverflow.clip,
                            ),
                            buildText(
                              'Bạn đang đăng ký gói ${'KabGo Premium'}. Hãy đảm bảo rằng tất cả tài liệu của bạn đã được cập nhật',
                              kBlackColor,
                              12,
                              FontWeight.w400,
                              TextAlign.start,
                              TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa chữ và hình ảnh
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/register/docs.png',
                            // Đặt các thuộc tính của hình ảnh theo nhu cầu
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Thông tin cá nhân',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          context.push(PersonImage.path);
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                          title: 'Ảnh cá nhân',
                          isCompleted:
                              ref.watch(statusProvider).isCompletedImgPerson,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.push(IdPersonInfo.path);
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                            title: 'CCCD/CMND/Hộ chiếu',
                            isCompleted:
                                ref.watch(statusProvider).isCompletedID),
                      ),
                      InkWell(
                        onTap: () {
                          context.push(DivingLicense.path);
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                            title: 'Bằng lái xe',
                            isCompleted:
                                ref.watch(statusProvider).isCompletedLicense),
                      ),
                      InkWell(
                        onTap: () {
                          context.push(EmergencyContactInfo.path);
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                            title:
                                'Thông tin liên hệ khẩn cấp và địa chỉ tạm trú',
                            isCompleted:
                                ref.watch(statusProvider).isCompletedEmergency),
                      ),
                      InkWell(
                        onTap: () {
                          context.push(VehicleInfo.path);
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                            title: 'Hình ảnh xe',
                            isCompleted: ref
                                .watch(statusProvider)
                                .isCompletedImgVehicle),
                      ),
                      InkWell(
                        onTap: () {
                          context.push(DrivingRegister.path);
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                            title: 'Giấy đăng ký xe',
                            isCompleted: ref
                                .watch(statusProvider)
                                .isCompletedRegisterVehicle),
                      ),
                      InkWell(
                        onTap: () {
                          context.push(VehicleInsurance.path);
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                            title: 'Bảo hiểm xe',
                            isCompleted:
                                ref.watch(statusProvider).isCompletedInsurance),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: WButton(
          width: double.infinity,
          radius: 50,
          shadow: const BoxShadow(
            color: Colors.transparent,
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 63, 63, 63),
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0,
            alignment: Alignment.center,
          ),
          onPressed: isCompletedAll ? handleRegister : null,
          child: Text(
            'Nộp hồ sơ',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isCompletedAll ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
