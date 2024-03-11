import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/constants/regex.dart';
import 'package:driver/data/data.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/bottom_selector.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const path = '/register';
  static const name = 'register_screen';
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isDataLoaded = false;

  final TextEditingController firstnameDriver = TextEditingController();
  final TextEditingController lastnameDriver = TextEditingController();
  final TextEditingController phonenumberDriver = TextEditingController();
  final TextEditingController referrerDriver = TextEditingController();
  late String selectedCity = '';

  late bool isChecked = false;
  late bool isValid = false;

  void sendCategory(var data) async {
    try {
      String baseURL = dotenv.env['API_BASE_URL']!;
      print('$baseURL/register');
      final dioClient = DioClient();
      print(data);

      print(dioClient);

      final response = await dioClient.request(
        '/register',
        options: Options(method: 'POST'),
        data: data,
      );
      // print(response.data['data']['id']);

      if (response.statusCode == 200) {
        ref
            .read(driverInfoRegisterProvider.notifier)
            .setIdDriver(response.data['data']['id']);
        ref
            .read(driverInfoRegisterProvider.notifier)
            .setLastName(response.data['data']['lastName']);

        // ignore: use_build_context_synchronously
        context.pushNamed(OTPScreen.name, extra: {
          'firstname': firstnameDriver.text,
          'lastname': lastnameDriver.text,
          'phonenumber': phonenumberDriver.text,
          'city': selectedCity,
          'referrer': referrerDriver.text,
        });
        // print(response.data['data']['id']);
      } else {
        // Xử lý lỗi nếu có
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
    }
  }

  void saveForm() {
    print('===== SAVE =====');
    // print(firstnameDriver.text);
    // print(lastnameDriver.text);
    // print(phonenumberDriver.text);
    // print(referrerDriver.text);
    // print(selectedCity);

    var data = json.encode({
      'firstName': firstnameDriver.text,
      'lastName': lastnameDriver.text,
      'phoneNumber': phonenumberDriver.text,
      'referralCode': referrerDriver.text,
      'city': selectedCity,
      'email': 'htvinh201@gmail.com'
    });

    sendCategory(data);
  }

  validFormField() {
    return firstnameDriver.text.isNotEmpty &&
        lastnameDriver.text.isNotEmpty &&
        phonenumberDriver.text.isNotEmpty &&
        phonenumerRegex.hasMatch(phonenumberDriver.text) &&
        selectedCity.isNotEmpty &&
        (isChecked == true);
  }

  updateValidFormField() {
    setState(() {
      isValid = validFormField();
    });
  }

  handleFormChange() {
    updateValidFormField();
  }

  handleRegister() async {
    if (_formKey.currentState != null &&
        validFormField() &&
        _formKey.currentState!.validate()) {
      saveForm();
    }
  }

  openCitySelector() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return BottomSheetSelector(
          label: const Text(
            'Chọn thành phố',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          options: cities,
          onSelected: (selectedOption) {
            setState(() {
              selectedCity = selectedOption;
              updateValidFormField();
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    firstnameDriver.dispose();
    lastnameDriver.dispose();
    phonenumberDriver.dispose();
    referrerDriver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/logo-hori.png'),
                          width: 120,
                        ),
                        const Spacer(),
                        InkWell(
                          child: const FaIcon(FontAwesomeIcons.xmark),
                          onTap: () {
                            context.pop();
                          },
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildText(
                              'Đăng ký tài xế mới',
                              kBlackColor,
                              22,
                              FontWeight.bold,
                              TextAlign.start,
                              TextOverflow.clip,
                            ),
                            const SizedBox(height: 8),
                            buildText(
                              'Vui lòng cung cấp đầy đủ thông tin để chúng tôi có thể hiểu rõ về bạn.',
                              kBlackColor,
                              12,
                              FontWeight.w400,
                              TextAlign.start,
                              TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/register/note.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    onChanged: handleFormChange,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: firstnameDriver,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Vui lòng nhập "Tên"';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tên*',
                          ),
                        ),
                        const SizedBox(height: 21),
                        TextFormField(
                          controller: lastnameDriver,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Vui lòng nhập "Họ và tên lót"';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Họ và tên lót*',
                          ),
                        ),
                        const SizedBox(height: 21),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 219, 219, 219),
                                    width: 1.0,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 14,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/register/vietnam.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        '+84',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: phonenumberDriver,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    return phonenumerRegex.hasMatch(value)
                                        ? null
                                        : 'Số điện thoại không tồn tại';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Số điện thoại*',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 21),
                        InkWell(
                          onTap: openCitySelector,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: const Color.fromARGB(255, 219, 219, 219),
                                width: 1.0,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 14,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    selectedCity.isEmpty
                                        ? 'Thành phố*'
                                        : selectedCity,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedCity.isEmpty
                                          ? Colors.black54
                                          : Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  const FaIcon(
                                    FontAwesomeIcons.chevronRight,
                                    size: 12,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 4),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 21),
                        TextFormField(
                          controller: referrerDriver,
                          decoration: const InputDecoration(
                            labelText: 'Mã giới thiệu',
                          ),
                        ),
                        const SizedBox(height: 21),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).primaryColor,
                                value: isChecked,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      isChecked = value ?? false;
                                    },
                                  );
                                  updateValidFormField();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text:
                                          'Bằng cách tiếp tục, tôi đồng ý với việc KabGo có thể thu thập, sử dụng và tiết lộ thông tin do tôi cung cấp theo ',
                                      style: TextStyle(
                                        color: COLOR_TEXT_MAIN,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Thông báo về quyền riêng tư',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(
                                      text:
                                          '. Tôi cũng xác nhận đã đọc, hiểu rõ và hoàn toàn tuân thủ các ',
                                      style: TextStyle(
                                        color: COLOR_TEXT_MAIN,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Điều khoản và điều kiện.',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 35),
                        WButton(
                          width: double.infinity,
                          radius: 50,
                          shadow: const BoxShadow(
                            color: Colors.transparent,
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 63, 63, 63),
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 0,
                            alignment: Alignment.center,
                          ),
                          onPressed: isValid ? handleRegister : null,
                          child: Text(
                            'Tiếp tục',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: isValid ? Colors.white : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
