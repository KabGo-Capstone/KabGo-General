import 'dart:io';

import 'package:driver/constants/colors.dart';
import 'package:driver/constants/font.dart';
import 'package:driver/data/data.dart';
import 'package:driver/screens/register_screen/remind_info/remind_certificate_after.dart';
import 'package:driver/screens/register_screen/remind_info/remind_certificate_before.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/build_text_field.dart';
import 'package:flutter/material.dart';

class DrivingRegister extends StatefulWidget {
  const DrivingRegister({super.key});

  @override
  State<DrivingRegister> createState() => _DrivingRegisterState();
}

class _DrivingRegisterState extends State<DrivingRegister> {
  TextEditingController licensePlates = TextEditingController();
  TextEditingController vehicleTemplate = TextEditingController();
  bool isAllFieldsValid = false;
  final _formKey = GlobalKey<FormState>();
  String? selectedRelation;
  File? _image;
  String? selectedFuelType;
  String? vehicleBrand;

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/register/person_info.png',
                          height: 160,
                        ),
                      ),
                    ],
                  ),
                  buildText(
                    'Giấy đăng ký xe',
                    kBlackColor,
                    18,
                    FontWeight.w600,
                    TextAlign.start,
                    TextOverflow.clip,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Mặt trước ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RemindCertificateBefore(),
                                ),
                              );
                            },
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200], // Màu nền
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: _image != null
                                      ? Image.file(_image!)
                                      : const SizedBox(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  size: 30,
                                                  color: COLOR_GRAY,
                                                ),
                                                Text(
                                                  'Tải ảnh lên',
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                )
                                              ]),
                                        ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Mặt sau ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RemindCertificateAfter(),
                                ),
                              );
                            },
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200], // Màu nền
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: _image != null
                                      ? Image.file(_image!)
                                      : const SizedBox(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  size: 30,
                                                  color: COLOR_GRAY,
                                                ),
                                                Text(
                                                  'Tải ảnh lên',
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                )
                                              ]),
                                        ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                    hint: 'Biển số xe',
                    controller: licensePlates,
                    inputType: TextInputType.text,
                    fillColor: kWhiteColor,
                    onChange: (value) {
                      validateFields();
                    },
                    labelText: 'Biển số xe*',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập biển số xe';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedFuelType,
                    onChanged: (newValue) {
                      setState(() {
                        selectedFuelType = newValue!;
                      });
                    },
                    items: fuelTypes.map((place) {
                      return DropdownMenuItem(
                        value: place,
                        child: Text(
                          place,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      label: const Text('Loại nhiên liệu*'),
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(width: 1, color: kRed)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(width: 1, color: kGrey1)),
                      focusColor: kWhiteColor,
                      hoverColor: kWhiteColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn loại nhiên liệu';
                      }
                      return null;
                    },
                    isExpanded: true,
                    itemHeight: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: vehicleBrand,
                    onChanged: (newValue) {
                      setState(() {
                        vehicleBrand = newValue!;
                      });
                    },
                    items: vehicleBrands.map((place) {
                      return DropdownMenuItem(
                        value: place,
                        child: Text(
                          place,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      label: const Text('Hãng xe*'),
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(width: 1, color: kRed)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(width: 1, color: kGrey1)),
                      focusColor: kWhiteColor,
                      hoverColor: kWhiteColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn hãng xe';
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
                    hint: 'Mẫu xe',
                    controller: vehicleTemplate,
                    inputType: TextInputType.text,
                    fillColor: kWhiteColor,
                    onChange: (value) {
                      validateFields();
                    },
                    labelText: 'Mẫu xe*',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập mẫu xe';
                      }
                      return null;
                    },
                  ),
                ],
              ),
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
              color: !isAllFieldsValid ? kOrange : kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
