import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/status_provider.dart';
import 'package:driver/screens/register_screen/info_detail/email_info.dart';
import 'package:driver/screens/register_screen/info_detail/driving_license.dart';
import 'package:driver/screens/register_screen/info_detail/driving_register.dart';
import 'package:driver/screens/register_screen/info_detail/emergency_contact.dart';
import 'package:driver/screens/register_screen/info_detail/id_person.dart';
import 'package:driver/screens/register_screen/info_detail/person_image.dart';
import 'package:driver/screens/register_screen/info_detail/vehicle_info.dart';
import 'package:driver/screens/register_screen/info_detail/vehicle_insurance.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/item_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoRegister extends ConsumerStatefulWidget {
  static const path = '/info_register';
  static const name = 'info';
  final String selectedService;
  const InfoRegister({
    super.key,
    required this.selectedService,
  });

  @override
  ConsumerState<InfoRegister> createState() => _InfoRegisterState();
}

class _InfoRegisterState extends ConsumerState<InfoRegister> {
  bool isCompletedAll = false;
  bool isLoading = false;
  String? idDriver;

  @override
  Widget build(BuildContext context) {
    print('Infor register rebuilt');

    final status = ref.watch(statusProvider);
    isCompletedAll = status.isCompletedEmail &&
        status.isCompletedEmergency &&
        status.isCompletedID &&
        status.isCompletedImgPerson &&
        status.isCompletedImgVehicle &&
        status.isCompletedInsurance &&
        status.isCompletedLicense &&
        status.isCompletedRegisterVehicle;

    handleRegister() async {
      idDriver = ref.watch(driverInfoRegisterProvider).id ?? '6';

      if (idDriver != null) {
        setState(() {
          isLoading = true;
        });

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(title: ''),
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
                              'Bạn đang đăng ký gói ${widget.selectedService}. Hãy đảm bảo rằng tất cả tài liệu của bạn đã được cập nhật',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PersonImage(),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IdPersonInfo(),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DivingLicense(),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmergencyContactInfo(),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VehicleInfo(),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DrivingRegister(),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VehicleInsurance(),
                            ),
                          );
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                            title: 'Bảo hiểm xe',
                            isCompleted:
                                ref.watch(statusProvider).isCompletedInsurance),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BankInfo(),
                            ),
                          );
                        },
                        splashColor: const Color.fromARGB(55, 255, 153, 0),
                        highlightColor: const Color.fromARGB(55, 255, 153, 0),
                        child: ItemInfo(
                            title: 'Liên kết email',
                            isCompleted:
                                ref.watch(statusProvider).isCompletedEmail),
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
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: isCompletedAll
              ? () async {
                  // Navigator.pop(context);
                  handleRegister();
                }
              : null, // Không cho phép nhấn nếu isCompletedAll là false
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kOrange),
          ),
          child: const Text(
            'Nộp hồ sơ',
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
