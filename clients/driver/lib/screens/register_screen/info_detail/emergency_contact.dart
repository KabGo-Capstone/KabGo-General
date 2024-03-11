import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/constants/font.dart';
import 'package:driver/data/data.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/emergency_contact_provider.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyContactInfo extends ConsumerStatefulWidget {
  const EmergencyContactInfo({super.key});

  @override
  ConsumerState<EmergencyContactInfo> createState() =>
      _EmergencyContactInfoState();
}

class _EmergencyContactInfoState extends ConsumerState<EmergencyContactInfo> {
  TextEditingController nameContactController = TextEditingController();
  TextEditingController phoneContactController = TextEditingController();
  TextEditingController addressContactController = TextEditingController();
  bool isAllFieldsValid = false;
  final _formKey = GlobalKey<FormState>();
  String? selectedRelation;
  late String? idDriver;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   // Thực hiện ref.watch() trong didChangeDependencies()
  //   final emergencyContact = ref.watch(emergencyContactProvider);

  //   nameContactController.text = emergencyContact.nameContact!;
  //   selectedRelation = emergencyContact.relationship!;
  //   phoneContactController.text = emergencyContact.phoneContact!;
  //   addressContactController.text = emergencyContact.addressContact!;
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  handleRegister() async {
    idDriver = ref.watch(driverInfoRegisterProvider).id ?? '6';
    nameContactController.text =
        ref.watch(emergencyContactProvider).nameContact!;
    selectedRelation = ref.watch(emergencyContactProvider).relationship!;
    phoneContactController.text =
        ref.watch(emergencyContactProvider).phoneContact!;
    addressContactController.text =
        ref.watch(emergencyContactProvider).addressContact!;
    // print('idDriver');
    print(nameContactController.text);
    print(selectedRelation);
    print(phoneContactController.text);
    print(addressContactController.text);

    if (idDriver != null && selectedRelation != null) {
      setState(() {
        isLoading = true;
      });

      var dataUpdateEmergencyContact = json.encode(
          {'id': idDriver, 'currentAddress': addressContactController.text});

      try {
        final dioClient = DioClient();

        final responseImgBefore = await dioClient.request(
          '/update-address',
          options: Options(method: 'POST'),
          data: dataUpdateEmergencyContact,
        );

        // print('API');
        // print(responseImgBefore.data);
        // print(responseImgAfter.data);

        if (responseImgBefore.statusCode == 200) {
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
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

  void validateFields() {
    setState(() {
      isAllFieldsValid = _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedRelation = ref.watch(emergencyContactProvider).relationship;
    if (ref.watch(emergencyContactProvider).nameContact != null) {
      nameContactController.text =
          ref.watch(emergencyContactProvider).nameContact!;
    }
    if (ref.watch(emergencyContactProvider).addressContact != null) {
      addressContactController.text =
          ref.watch(emergencyContactProvider).addressContact!;
    }
    if (ref.watch(emergencyContactProvider).phoneContact != null) {
      phoneContactController.text =
          ref.watch(emergencyContactProvider).phoneContact!;
    }

    return Scaffold(
      appBar: const AppBarCustom(title: ''),
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          GestureDetector(
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
                            controller: nameContactController,
                            inputType: TextInputType.text,
                            fillColor: kWhiteColor,
                            onChange: (value) {
                              validateFields();
                              ref
                                  .read(emergencyContactProvider.notifier)
                                  .setNameContact(value);
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
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: COLOR_TEXT_MAIN),
                            onChanged: (newValue) {
                              setState(() {
                                selectedRelation = newValue!;
                                ref
                                    .read(emergencyContactProvider.notifier)
                                    .setRelationship(newValue);
                              });
                            },
                            items: relationships.map((relation) {
                              return DropdownMenuItem(
                                value: relation,
                                child: SizedBox(
                                  child: Text(
                                    relation,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              label: const Text('Quan hệ*'),
                              labelStyle:
                                  const TextStyle(fontSize: 14, color: kGrey0),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(width: 1, color: kOrange),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 192, 192, 192)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(width: 0, color: kGrey1),
                              ),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide:
                                      BorderSide(width: 1, color: kRed)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide:
                                      BorderSide(width: 1, color: kGrey1)),
                              focusColor: kWhiteColor,
                              hoverColor: kWhiteColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng chọn quan hệ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BuildTextField(
                            controller: phoneContactController,
                            inputType: TextInputType.text,
                            fillColor: kWhiteColor,
                            onChange: (value) {
                              validateFields();
                              ref
                                  .read(emergencyContactProvider.notifier)
                                  .setPhoneContact(value);
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
                            // hint: 'Địa chỉ tạm trú của tài xế',
                            controller: addressContactController,
                            inputType: TextInputType.text,
                            fillColor: kWhiteColor,
                            onChange: (value) {
                              validateFields();
                              ref
                                  .read(emergencyContactProvider.notifier)
                                  .setAddressContact(value);
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
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              handleRegister();
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
