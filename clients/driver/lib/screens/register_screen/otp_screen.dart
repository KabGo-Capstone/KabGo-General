import 'dart:async';
import 'package:driver/constants/colors.dart';
import 'package:driver/models/user_register.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  static const path = '/otpscreen';
  static const name = 'otp_screen';
  final UserRegister user;
  const OTPScreen({super.key, required this.user});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late int _remainingSeconds;
  late Timer _timer;

  final TextEditingController otpCode = TextEditingController();
  final formKey = GlobalKey<FormState>();

  handleRegister(otpValue) {
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
  }

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 120;
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
        return _timer.cancel();
      }
      setState(() {
        _remainingSeconds = _remainingSeconds > 0 ? _remainingSeconds - 1 : 120;
        if (_remainingSeconds == 0) {
          // process send new OTP code
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText(
                    'Xác minh tài khoản với mã OTP',
                    kBlackColor,
                    28,
                    FontWeight.bold,
                    TextAlign.start,
                    TextOverflow.clip,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildText(
                    'Vui lòng nhập mã OTP với 6 chữ số được gửi đến số điện thoại +84 ${widget.user.phonenumber.substring(0, 4)}******',
                    Colors.black54,
                    13,
                    FontWeight.w400,
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
                            onCompleted: handleRegister,
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                            controller: otpCode,
                            length: 6,
                            cursorHeight: 30,
                            cursorWidth: 1.5,
                            animationType: AnimationType.fade,
                            enableActiveFill: true,
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldWidth: 58,
                              fieldHeight: 70,
                              inactiveColor: Colors.grey.shade400,
                              selectedColor: Theme.of(context).primaryColor,
                              activeFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              inactiveBorderWidth: 0.5,
                              activeBorderWidth: 1,
                              selectedBorderWidth: 0.5,
                              borderRadius: BorderRadius.circular(10),
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
                      'Bạn không nhận được mã ?',
                      Colors.black54,
                      14,
                      FontWeight.w600,
                      TextAlign.start,
                      TextOverflow.clip,
                    ),
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Yêu cầu mã mới sau ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '$_remainingSeconds',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
