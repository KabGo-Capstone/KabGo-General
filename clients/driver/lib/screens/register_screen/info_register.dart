import 'package:driver/constants/colors.dart';
import 'package:driver/screens/register_screen/info_detail/bank_info.dart';
import 'package:driver/screens/register_screen/info_detail/driving_license.dart';
import 'package:driver/screens/register_screen/info_detail/driving_register.dart';
import 'package:driver/screens/register_screen/info_detail/emergency_contact.dart';
import 'package:driver/screens/register_screen/info_detail/id_person.dart';
import 'package:driver/screens/register_screen/info_detail/person_image.dart';
import 'package:driver/screens/register_screen/info_detail/vehicle_info.dart';
import 'package:driver/screens/register_screen/info_detail/vehicle_insurance.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/item_info.dart';
import 'package:flutter/material.dart';

class InfoRegister extends StatefulWidget {
  static const path = '/info_register';
  static const name = 'info';
  final String selectedService;
  const InfoRegister({
    super.key,
    required this.selectedService,
  });

  @override
  State<InfoRegister> createState() => _InfoRegisterState();
}

class _InfoRegisterState extends State<InfoRegister> {
  bool isCompleted = false;
  bool isCompleted2 = true;
  @override
  Widget build(BuildContext context) {
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
                        child: const ItemInfo(
                          title: 'Ảnh cá nhân',
                          isCompleted: true,
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
                        child: const ItemInfo(
                            title: 'CCCD/CMND/Hộ chiếu', isCompleted: false),
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
                        child: const ItemInfo(
                            title: 'Bằng lái xe', isCompleted: false),
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
                        child: const ItemInfo(
                            title:
                                'Thông tin liên hệ khẩn cấp và địa chỉ tạm trú',
                            isCompleted: false),
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
                        child: const ItemInfo(
                            title: 'Tài khoản ngân hàng', isCompleted: false),
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
                        child: const ItemInfo(
                            title: 'Hình ảnh xe', isCompleted: false),
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
                        child: const ItemInfo(
                            title: 'Giấy đăng ký xe', isCompleted: false),
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
                        child: const ItemInfo(
                            title: 'Bảo hiểm xe', isCompleted: false),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
