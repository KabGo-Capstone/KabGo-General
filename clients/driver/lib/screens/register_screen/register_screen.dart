import 'package:driver/constants/colors.dart';
import 'package:driver/data/data.dart';
import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/build_text_field.dart';
import 'package:driver/widgets/city_dropdown.dart';
import 'package:driver/widgets/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  static const path = '/register';
  static const name = 'register_screen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameDriver = TextEditingController();
  TextEditingController surnameDriver = TextEditingController();
  TextEditingController phoneDriver = TextEditingController();
  TextEditingController introduceCode = TextEditingController();
  bool isChecked = false;
  bool isAllFieldsValid = false;
  final _formKey = GlobalKey<FormState>();

  void validateFields() {
    setState(() {
      isAllFieldsValid = _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: COLOR_WHITE,
          actions: [
            OutlinedButton(
              onPressed: () {
                debugPrint('Cần hỗ trợ');
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
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView(
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
                                    'Đăng ký tài xế mới',
                                    kBlackColor,
                                    18,
                                    FontWeight.w600,
                                    TextAlign.start,
                                    TextOverflow.clip,
                                  ),
                                  buildText(
                                    'Vui lòng cho chúng tôi biết về bạn',
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
                                  'assets/images/register/note.png',
                                  // Đặt các thuộc tính của hình ảnh theo nhu cầu
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BuildTextField(
                            hint: 'Tên*',
                            controller: nameDriver,
                            inputType: TextInputType.text,
                            fillColor: kWhiteColor,
                            validatorString: 'Vui lòng nhập tên',
                            onChange: (value) {
                              validateFields();
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        BuildTextField(
                            hint: 'Họ',
                            controller: surnameDriver,
                            inputType: TextInputType.text,
                            fillColor: kWhiteColor,
                            onChange: (value) {}),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const CountryDropdown(),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: BuildTextField(
                                hint: 'Số điện thoại di động*',
                                controller: phoneDriver,
                                inputType: TextInputType.phone,
                                fillColor: kWhiteColor,
                                validatorString: 'Vui lòng nhập số điện thoại',
                                onChange: (value) {
                                  validateFields();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            CustomDropdown(
                              dataDefault: 'Hồ Chí Minh',
                              data: cities,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BuildTextField(
                            hint: 'Mã giới thiệu',
                            controller: introduceCode,
                            inputType: TextInputType.text,
                            fillColor: kWhiteColor,
                            onChange: (value) {}),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              child: SizedBox(
                                width: 24, 
                                height: 24, 
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.green,
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'Bằng cách tiếp tục, tôi đồng ý với việc KabGo có thể thu thập, sử dụng và tiết lộ thông tin do tôi cung cấp theo ',
                                          style: TextStyle(
                                            color: COLOR_TEXT_MAIN,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Thông báo về quyền riêng tư',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '. Tôi cũng xác nhận đã đọc, hiểu rõ và hoàn toàn tuân thủ các ',
                                          style: TextStyle(
                                            color: COLOR_TEXT_MAIN,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Điều khoản và điều kiện',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Nút "Tiếp tục" được gắn cố định ở dưới màn hình
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: ElevatedButton(
            onPressed: isAllFieldsValid && isChecked
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPScreen(
                          phoneNumber: phoneDriver.text,
                        ),
                      ),
                    );
                  }
                : null,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (isChecked && isAllFieldsValid) {
                  return kOrange;
                } else {
                  return const Color.fromARGB(255, 240, 240, 240);
                }
              }),
            ),
            child: Text(
              'Tiếp tục',
              style: TextStyle(
                fontSize: 16,
                color: !isChecked || !isAllFieldsValid ? kOrange : kWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
