import 'dart:async';

import 'package:driver/constants/colors.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  static const path = '/otpscreen';
  static const name = 'otp_screen';
  final String phoneNumber;
  const OTPScreen({super.key, required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late int _remainingSeconds;
  late Timer _timer;
  TextEditingController otpCode = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 60;
    otpCode = TextEditingController();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        _timer.cancel(); // Dừng hẹn giờ nếu widget đã bị dispose
        return;
      }
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel(); // Dừng hẹn giờ khi đã đếm ngược xong
        }
      });
    });
  }

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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  'Kiểm tra tin nhắn SMS của bạn',
                  kBlackColor,
                  18,
                  FontWeight.w600,
                  TextAlign.start,
                  TextOverflow.clip,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildText(
                  'Chúng tôi đã gửi một mã có 4 chữ số đến số điện thoại',
                  kBlackColor,
                  12,
                  FontWeight.w400,
                  TextAlign.start,
                  TextOverflow.clip,
                ),
                buildText(
                  widget.phoneNumber,
                  kBlackColor,
                  12,
                  FontWeight.w600,
                  TextAlign.start,
                  TextOverflow.clip,
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: PinCodeTextField(
                          onCompleted: (otpValue) {
                            if (otpValue.length == 6) {
                              debugPrint('Mã OTP: $otpValue');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SelectService(),
                                ),
                              );
                            } else {
                              debugPrint('Mã OTP không hợp lệ');
                            }
                          },
                          onChanged: (value) {},
                          beforeTextPaste: (text) {
                            debugPrint('Allowing to paste $text');
                            return true;
                          },
                          appContext: context,
                          controller: otpCode,
                          length: 6,
                          cursorHeight: 19,
                          animationType: AnimationType.fade,
                          enableActiveFill: true,
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldWidth: 50,
                            inactiveColor: Colors.white,
                            selectedColor: Colors.orange,
                            activeFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            inactiveFillColor: Colors.grey.shade100,
                            activeBorderWidth: 0.5,
                            selectedBorderWidth: 0.5,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: buildText(
                    'Bạn không nhận được mã?',
                    kBlackColor,
                    12,
                    FontWeight.w500,
                    TextAlign.start,
                    TextOverflow.clip,
                  ),
                ),
                Center(
                  child: Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                        text: 'Yêu cầu mã mới sau ',
                        style: TextStyle(
                          color: COLOR_GRAY,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '$_remainingSeconds s',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: ElevatedButton(
      //     onPressed: () {
      //       // Kiểm tra nếu độ dài của mã OTP không đủ 6 ký tự, không cho phép chuyển màn hình
      //       if (otpCode.text.length != 6) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(
      //             content: Text('Mã OTP phải có 6 ký tự'),
      //           ),
      //         );
      //       } else {
      //         // Kiểm tra điều kiện hợp lệ trước khi chuyển màn hình
      //         if (formKey.currentState!.validate()) {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const SelectService(),
      //             ),
      //           );
      //         } else {
      //           // Hiển thị thông báo nếu mã OTP không hợp lệ
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(
      //               content: Text('Mã OTP không hợp lệ'),
      //             ),
      //           );
      //         }
      //       }
      //     },
      //     style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      //         // Kiểm tra điều kiện để đảo ngược màu nền và màu chữ
      //         if (otpCode.text.length != 6) {
      //           return Colors.white; // Màu nền khi mã OTP không hợp lệ
      //         }
      //       }),
      //       foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      //         if (otpCode.text.length != 6) {
      //           return kOrange;
      //         }
      //       }),
      //     ),
      //     child: Text(
      //       'Xác nhận',
      //       style: TextStyle(
      //         fontSize: 16,
      //         color: otpCode.text.length != 6 ? kOrange : kWhiteColor,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
