import 'package:driver/constants/colors.dart';
import 'package:driver/screens/register_screen/info_detail/person_image.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/item_info.dart';
import 'package:flutter/material.dart';

class InfoRegister extends StatefulWidget {
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
      appBar: AppBar(
        backgroundColor: COLOR_WHITE,
        actions: [
          OutlinedButton(
            onPressed: () {
              print('Cần hỗ trợ');
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(0, 0)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
              side: MaterialStateProperty.all(const BorderSide(
                  color: Color.fromARGB(255, 97, 97, 97), width: 0.7)),
            ),
            child: const Text(
              'Cần hỗ trợ?',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
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
                      child: const ItemInfo(
                          title: 'Ảnh cá nhân', isCompleted: true),
                    ),
                    const ItemInfo(
                        title: 'CCCD/CMND/Hộ chiếu', isCompleted: true),
                    const ItemInfo(title: 'Bằng lái xe', isCompleted: true),
                    const ItemInfo(title: 'Bằng lái xe', isCompleted: true),
                    const ItemInfo(
                        title: 'Tài khoản ngân hàng', isCompleted: true),
                    const ItemInfo(title: 'Giấy đăng ký xe', isCompleted: true),
                    const ItemInfo(title: 'Bảo hiểm xe', isCompleted: false),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
