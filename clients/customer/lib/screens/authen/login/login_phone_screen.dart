import 'package:customer/screens/authen/login/function/get_data_mobile_phone.dart';
import 'package:customer/screens/authen/login/widget/choose_phone.dart';
import 'package:customer/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> data = getDataMobilePhone();
    final Map<String, dynamic> currentMobileSeleted = data[0];
    bool isCheckValidation = false;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const FaIcon(FontAwesomeIcons.chevronLeft)),
            const Spacer(),
            const Text('Bắt đầu'),
            const Spacer(),
            const Visibility(visible: false, child: Icon(Icons.arrow_back)),
          ],
        ),
        automaticallyImplyLeading: false, // Don't show the leading button
      ),
      body: PopScope(
        canPop: false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Số Di động',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            isScrollControlled: true,
                            builder: ((context) {
                              return const ChoosePhoneWidget();
                            }));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'lib/assets/images/facebook_logo.png',
                            fit: BoxFit.contain,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            currentMobileSeleted['value'],
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: TextFormField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        if (validatePhoneNumber(value)) {
                          setState(() {
                            isCheckValidation = true;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        if (validatePhoneNumber(value) == false) {
                          return 'Số điện thoại không hợp lệ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Nhập số điện thoại',
                      ),
                    ))
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 54,
                  child: Opacity(
                    opacity: 1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black)),
                        backgroundColor: isCheckValidation
                            ? MaterialStateProperty.all(const Color(0xffEF773F))
                            : MaterialStateProperty.all(Colors.grey.withOpacity(0.6)),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Tiếp tục',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
