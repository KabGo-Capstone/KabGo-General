import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/models/driver_service.dart';
import 'package:driver/models/user_register.dart';
import 'package:driver/providers/auth_provider.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/home_dashboard/home_dashboard.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/shake_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends ConsumerStatefulWidget {
  static const path = '/otpscreen';
  static const name = 'otp_screen';
  final UserRegister user;
  const OTPScreen({super.key, required this.user});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  final TextEditingController otpCode = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void sendCategory(var otp) {
    final phoneProvider = ref.read(phoneAuthProvider);

    phoneProvider.verifyOTP(otp).then((credential) {
      if (credential == null) return;

      phoneProvider.phoneValidate(OTPScreen.path).then((data) {
        SharedPreferences.getInstance().then((prefs) {
          if (data['user'] != null) {
            if (data['redirect'] == HomeDashboard.path) {
              data['user']['verified'] = true;
            }
            prefs.setString('user-profile', jsonEncode(data['user']));
          }

          final driverInfoNotifier =
              ref.read(driverInfoRegisterProvider.notifier);

          driverInfoNotifier.setIdDriver(data['user']['id']);
          driverInfoNotifier.setLastName(data['user']['lastName']);
          driverInfoNotifier.setFirstName(data['user']['firstName']);
          driverInfoNotifier.setPhoneNumber(data['user']['phoneNumber']);

          if (data['redirect'] == HomeDashboard.path) {
            driverInfoNotifier.setAvatar(data['user']['avatar']);
            final dioClient = DioClient();
              final response = dioClient.request('/verify-user-registration',
                  options: Options(method: 'POST'), data: {}).then((response) {
                if (response.statusCode == 200) {
                  final services = [];
                  final List<dynamic> serviceListJson =
                      response.data['data']['services'];
                  for (var json in serviceListJson) {
                    services.add(Service.fromJson(json));
                  }

                  for (var service in services) {
                    if (service.id == data['user']['serviceID']) {
                      driverInfoNotifier.setServiceName(service.name);
                      break;
                    }
                  }
                }
                context.go(data['redirect']);
              });
          }
          else {
            context.go(data['redirect']);
          }
        });
      });
    }).catchError((e) {
      _shakeKey.currentState?.shake();
      otpCode.clear();
    }, test: (e) => true);
  }

  void saveForm() {
    sendCategory(otpCode.text);
  }

  handleRegister(otpValue) {
    if (otpValue.length == 6) {
      debugPrint('Mã OTP: $otpValue');
      saveForm();
    } else {
      debugPrint('Mã OTP không hợp lệ');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final _shakeKey = GlobalKey<ShakeWidgetState>();

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
                  const SizedBox(height: 8),
                  buildText(
                    'Vui lòng nhập mã OTP với 6 chữ số được gửi đến số điện thoại +84 ${widget.user.phoneNumber.substring(0, 4)}******',
                    Colors.black54,
                    12,
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
                          child: ShakeWidget(
                            key: _shakeKey,
                            shakeCount: 3,
                            shakeOffset: 10,
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
                  const TimeCounter(),
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

class TimeCounter extends StatefulWidget {
  const TimeCounter({super.key});

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  late int _remainingSeconds;
  late Timer _timer;
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
    return Center(
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
    );
  }
}
