import 'dart:io';

import 'package:driver/constants/colors.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_pick_date.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IdPersonInfo extends StatefulWidget {
  const IdPersonInfo({super.key});

  @override
  State<IdPersonInfo> createState() => _IdPersonInfoState();
}

class _IdPersonInfoState extends State<IdPersonInfo> {
  TextEditingController licenseDate = TextEditingController();
  TextEditingController licenseDateController = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: ''),
      backgroundColor: kWhiteColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
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
                  'CMND / Thẻ Căn Cước / Hộ Chiếu',
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
                        FittedBox(
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
                                  : const Icon(
                                      Icons.picture_in_picture_sharp,
                                      size: 50,
                                      color: COLOR_GRAY,
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
                        FittedBox(
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
                                  : const Icon(
                                      Icons.picture_in_picture_sharp,
                                      size: 50,
                                      color: COLOR_GRAY,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DateInputField(
                        controller: licenseDateController,
                        hintText: 'Chọn ngày cấp *',
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                            String formattedDate =
                                dateFormat.format(selectedDate);
                            licenseDateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BuildTextField(
                    hint: 'Nơi cấp *',
                    controller: licenseDate,
                    inputType: TextInputType.text,
                    fillColor: kWhiteColor,
                    validatorString: 'Nơi cấp',
                    onChange: (value) {
                      // validateFields();
                    }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kOrange),
          ),
          child: const Text(
            'Lưu',
            style: TextStyle(
              fontSize: 16,
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
