import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/constants/font.dart';
import 'package:driver/data/data.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/driver_provider.dart';
import 'package:driver/screens/register_screen/remind_info/remind_id_after.dart';
import 'package:driver/screens/register_screen/remind_info/remind_id_before.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_pick_date.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class IdPersonInfo extends ConsumerStatefulWidget {
  static const path = '/id_person';
  static const name = 'id_person';
  const IdPersonInfo({super.key});

  @override
  ConsumerState<IdPersonInfo> createState() => _IdPersonInfoState();
}

class _IdPersonInfoState extends ConsumerState<IdPersonInfo> {
  TextEditingController licenseDate = TextEditingController();
  TextEditingController licenseDateController = TextEditingController();
  File? imageBefore;
  File? imageAfter;
  String? selectedPlaceOfIssue;

  late String? idDriver;

  handleRegister() async {
    idDriver = ref.watch(driverInfoRegisterProvider).id ?? '1';
    imageBefore = ref.watch(driverProvider).fileIdImgBefore;
    imageAfter = ref.watch(driverProvider).fileIdImgAfter;
    print("idDriver");
    print(imageBefore);
    print(imageAfter);

    if (imageBefore != null && imageAfter != null) {
      var dataImageBefore = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageBefore!.path)],
        'id': '6'
      });

      var dataImageAfter = FormData.fromMap({
        'image': [await MultipartFile.fromFile(imageBefore!.path)],
        'id': '6'
      });

      try {
        final dioClient = DioClient();

        final responseImgBefore = await dioClient.request(
          '/upload/identity-img-frontsight',
          options: Options(method: 'POST'),
          data: dataImageBefore,
        );

        final responseImgAfter = await dioClient.request(
          '/upload/identity-img-backsight',
          options: Options(method: 'POST'),
          data: dataImageAfter,
        );
        print('API');
        print(responseImgBefore.data);
        print(responseImgAfter.data);

        if (responseImgBefore.statusCode == 200) {
          // ignore: use_build_context_synchronously
          // Navigator.pop(context);
        } else {
          // Handle error
        }
      } catch (e) {
        // Handle error
      }
    } else {
      print('Image is null!');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('id_person rebuild');
    imageBefore = ref.watch(driverProvider).fileIdImgBefore;
    imageAfter = ref.watch(driverProvider).fileIdImgAfter;

    // _image = ref.read(driverProvider).file;
    print(ref.watch(driverProvider).fileIdImgBefore);
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RemindIdBefore(),
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
                                child: imageBefore != null
                                    ? Image.file(imageBefore!)
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
                                                style: TextStyle(fontSize: 11),
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
                                builder: (context) => const RemindIdAfter(),
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
                                child: imageAfter != null
                                    ? Image.file(imageAfter!)
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
                                                style: TextStyle(fontSize: 11),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DateInputField(
                        controller: licenseDateController,
                        labelText: 'Chọn ngày cấp *',
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
                DropdownButtonFormField<String>(
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400, color: kGrey0),
                  value: selectedPlaceOfIssue,
                  onChanged: (newValue) {
                    setState(() {
                      selectedPlaceOfIssue = newValue!;
                    });
                  },
                  items: placesOfIssue.map((place) {
                    return DropdownMenuItem(
                      value: place,
                      child: Text(
                        place,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    label: const Text('Nơi cấp*'),
                    labelStyle: const TextStyle(fontSize: 14, color: kGrey0),
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
                          width: 0, color: Color.fromARGB(255, 192, 192, 192)),
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
                      return 'Vui lòng chọn quan hệ';
                    }
                    return null;
                  },
                  isExpanded: true,
                  itemHeight: 50,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: () async {
            handleRegister();
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
