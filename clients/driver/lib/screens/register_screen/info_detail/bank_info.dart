import 'package:driver/constants/colors.dart';
import 'package:driver/constants/font.dart';
import 'package:driver/data/data.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/build_text_field.dart';
import 'package:flutter/material.dart';

class BankInfo extends StatefulWidget {
  const BankInfo({super.key});

  @override
  State<BankInfo> createState() => _BankInfoState();
}

class _BankInfoState extends State<BankInfo> {
  TextEditingController nameCard = TextEditingController();
  TextEditingController numberCard = TextEditingController();
  String? selectedRelation;
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
                              'assets/images/register/bank.png',
                              height: 160,
                            ),
                          ),
                        ],
                      ),
                      buildText(
                        'Tài khoản ngân hàng',
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
                        hint: 'Tên chủ tài khoản',
                        controller: nameCard,
                        inputType: TextInputType.text,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          validateFields();
                        },
                        labelText: 'Tên chủ tài khoản*',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tên chủ tài khoản là trường dữ liệu bắt buộc';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildTextField(
                        hint: 'Số tài khoản',
                        controller: numberCard,
                        inputType: TextInputType.text,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          validateFields();
                        },
                        labelText: 'Số tài khoản*',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Số tài khoản là trường dữ liệu bắt buộc';
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
                        items: banks.map((relation) {
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
                          'Tên ngân hàng*',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff8D9091)),
                        ),
                        decoration: InputDecoration(
                          label: const Text('Tên ngân hàng'),
                          labelStyle: const TextStyle(
                              fontSize: 14, color: Color(0xff8D9091)),
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
                                Text(
                                    'Tôi cam kết cung cấp thông tin ngân hàng chính chủ của tôi')
                              ],
                            ),
                          )
                        ],
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
              if (isChecked && isAllFieldsValid) {
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
              color: !isChecked || !isAllFieldsValid ? kOrange : kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
