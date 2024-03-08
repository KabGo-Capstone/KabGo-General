import 'package:driver/constants/colors.dart';
import 'package:driver/constants/font.dart';
import 'package:driver/data/data.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/build_text_field.dart';
import 'package:flutter/material.dart';

class EmergencyContactInfo extends StatefulWidget {
  const EmergencyContactInfo({super.key});

  @override
  State<EmergencyContactInfo> createState() => _EmergencyContactInfoState();
}

class _EmergencyContactInfoState extends State<EmergencyContactInfo> {
  TextEditingController nameContact = TextEditingController();
  TextEditingController relationship = TextEditingController();
  TextEditingController phoneContact = TextEditingController();
  TextEditingController addressContact = TextEditingController();
  bool isAllFieldsValid = false;
  final _formKey = GlobalKey<FormState>();
  String? selectedRelation;

  void validateFields() {
    setState(() {
      isAllFieldsValid = _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: ''),
      backgroundColor: kWhiteColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/images/register/contact.png',
                              height: 160,
                            ),
                          ),
                        ],
                      ),
                      buildText(
                        'Thông tin liên hệ khẩn cấp và địa chỉ tạm trú',
                        kBlackColor,
                        18,
                        FontWeight.w600,
                        TextAlign.start,
                        TextOverflow.clip,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildTextField(
                        hint: 'Tên người liên hệ khẩn cấp',
                        controller: nameContact,
                        inputType: TextInputType.text,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          validateFields();
                        },
                        labelText: 'Tên người liên hệ khẩn cấp*',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập người liên hệ khẩn cấp';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedRelation,
                        onChanged: (newValue) {
                          setState(() {
                            selectedRelation = newValue!;
                          });
                        },
                        items: relationships.map((relation) {
                          return DropdownMenuItem(
                            value: relation,
                            child: SizedBox(
                              height: 30,
                              child: Text(
                                relation,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          'Quan hệ*',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff8D9091)),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kWhiteColor,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          errorStyle: const TextStyle(
                            fontSize: textSmall,
                            fontWeight: FontWeight.normal,
                            color: kRed,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(width: 1, color: kOrange),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromARGB(255, 192, 192, 192)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(width: 0, color: kGrey1),
                          ),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(width: 1, color: kRed)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(width: 1, color: kGrey1)),
                          focusColor: kWhiteColor,
                          hoverColor: kWhiteColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng chọn quan hệ';
                          }
                          return null;
                        },
                        isExpanded: true,
                        itemHeight: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildTextField(
                        controller: phoneContact,
                        inputType: TextInputType.text,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          validateFields();
                        },
                        labelText: 'Điện thoại liên hệ khẩn cấp*',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập số điện thoại liên hệ khẩn cấp';
                          } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                            return 'Số điện thoại chỉ chứa các ký tự số';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildTextField(
                        hint: 'Địa chỉ tạm trú của tài xế',
                        controller: addressContact,
                        inputType: TextInputType.text,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          validateFields();
                        },
                        labelText: 'Địa chỉ tạm trú của tài xế*',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập địa chỉ tạm trú của tài xế';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (isAllFieldsValid) {
                return kOrange;
              } else {
                return const Color.fromARGB(255, 240, 240, 240);
              }
            }),
          ),
          child: Text(
            'Lưu',
            style: TextStyle(
              fontSize: 16,
              color: isAllFieldsValid ? Colors.white : kOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

}
