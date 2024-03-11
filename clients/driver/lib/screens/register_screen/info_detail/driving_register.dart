import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/constants/font.dart';
import 'package:driver/data/data.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/providers/status_provider.dart';
import 'package:driver/providers/vehicle_register_provider.dart';
import 'package:driver/screens/register_screen/remind_info/remind_certificate_after.dart';
import 'package:driver/screens/register_screen/remind_info/remind_certificate_before.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/app_bar.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrivingRegister extends ConsumerStatefulWidget {
  const DrivingRegister({super.key});

  @override
  ConsumerState<DrivingRegister> createState() => _DrivingRegisterState();
}

class _DrivingRegisterState extends ConsumerState<DrivingRegister> {
  TextEditingController licensePlates = TextEditingController();
  TextEditingController vehicleTemplate = TextEditingController();
  TextEditingController vehicleColor = TextEditingController();
  bool isAllFieldsValid = false;
  final _formKey = GlobalKey<FormState>();
  File? vehicleRegisterBack;
  File? vehicleRegisterFront;
  String? selectedFuelType;
  String? vehicleBrand;

  bool isLoading = false;
  late String? idDriver;

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   // Thực hiện ref.watch() trong didChangeDependencies()
  //   selectedPlaceOfIssue = ref.watch(driverProvider).placeOfIssue!;
  //   licenseDateController.text = ref.watch(driverProvider).date!;
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  handleRegister() async {
    idDriver = ref.watch(driverInfoRegisterProvider).id ?? '6';
    vehicleRegisterFront =
        ref.watch(vehicleRegisterNotifier).vehicleRegisterFront;
    vehicleRegisterBack =
        ref.watch(vehicleRegisterNotifier).vehicleRegisterBack;

    licensePlates.text = ref.watch(vehicleRegisterNotifier).identityVehicle!;
    // selectedFuelType = ref.watch(vehicleRegisterNotifier).fuelVehicle;
    vehicleBrand = ref.watch(vehicleRegisterNotifier).brandVehicle;
    vehicleTemplate.text = ref.watch(vehicleRegisterNotifier).nameVehicle!;
    vehicleColor.text = ref.watch(vehicleRegisterNotifier).colorVehicle!;
    print('idDriver');
    print(vehicleRegisterFront);
    print(vehicleRegisterBack);

    print(licensePlates.text);
    print(vehicleTemplate.text);
    print(vehicleColor.text);
    print(selectedFuelType);

    if (vehicleRegisterFront != null &&
        vehicleRegisterBack != null &&
        vehicleBrand != null) {
      setState(() {
        isLoading = true;
      });
      var dataImageBefore = FormData.fromMap({
        'image': [await MultipartFile.fromFile(vehicleRegisterFront!.path)],
        'id': idDriver
      });

      var dataImageAfter = FormData.fromMap({
        'image': [await MultipartFile.fromFile(vehicleRegisterBack!.path)],
        'id': idDriver
      });

      var dataUpdateVehicle = json.encode({
        'id': idDriver,
        'name': vehicleTemplate.text,
        'identityNumber': licensePlates.text,
        'color': vehicleColor.text,
        'brand': vehicleBrand
      });

      try {
        final dioClient = DioClient();

        final responseImgBefore = await dioClient.request(
          '/upload/vehicle-registration-frontsight',
          options: Options(method: 'POST'),
          data: dataImageBefore,
        );

        final responseImgAfter = await dioClient.request(
          '/upload/vehicle-img-backsight',
          options: Options(method: 'POST'),
          data: dataImageAfter,
        );

        final responseIdentity = await dioClient.request(
          '/update-service',
          options: Options(method: 'POST'),
          data: dataUpdateVehicle,
        );
        // print('API');
        // print(responseImgBefore.data);
        // print(responseImgAfter.data);

        if (responseImgBefore.statusCode == 200 &&
            responseImgAfter.statusCode == 200 &&
            responseIdentity.statusCode == 200) {
          ref.read(statusProvider.notifier).setRegisterVehicle(true);
          setState(() {
            isLoading = false; // Đặt isLoading là false khi xử lý xong
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
    vehicleRegisterFront =
        ref.watch(vehicleRegisterNotifier).vehicleRegisterFront;
    vehicleRegisterBack =
        ref.watch(vehicleRegisterNotifier).vehicleRegisterBack;

    vehicleBrand = ref.watch(vehicleRegisterNotifier).brandVehicle;
    selectedFuelType = ref.watch(vehicleRegisterNotifier).fuelVehicle;

    if (ref.watch(vehicleRegisterNotifier).identityVehicle != null) {
      licensePlates.text = ref.watch(vehicleRegisterNotifier).identityVehicle!;
    }

    if (ref.watch(vehicleRegisterNotifier).nameVehicle != null) {
      vehicleTemplate.text = ref.watch(vehicleRegisterNotifier).nameVehicle!;
    }
    if (ref.watch(vehicleRegisterNotifier).colorVehicle != null) {
      vehicleColor.text = ref.watch(vehicleRegisterNotifier).colorVehicle!;
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
                                      child: vehicleRegisterFront != null
                                          ? Image.file(vehicleRegisterFront!)
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
                                                      style: TextStyle(
                                                          fontSize: 11),
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
                                      child: vehicleRegisterBack != null
                                          ? Image.file(vehicleRegisterBack!)
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
                                                      style: TextStyle(
                                                          fontSize: 11),
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
                          ref
                              .read(vehicleRegisterNotifier.notifier)
                              .setVehicleRegisterIdentity(value);
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
                            ref
                                .read(vehicleRegisterNotifier.notifier)
                                .setFuelVehicleRegister(newValue);
                          });
                        },
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: COLOR_TEXT_MAIN),
                        items: fuelTypes.map((place) {
                          return DropdownMenuItem(
                            value: place,
                            child: Text(
                              place,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          label: const Text('Loại nhiên liệu*'),
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
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: COLOR_TEXT_MAIN),
                        onChanged: (newValue) {
                          setState(() {
                            vehicleBrand = newValue!;
                            ref
                                .read(vehicleRegisterNotifier.notifier)
                                .setVehicleRegisterBrand(newValue);
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
                        // hint: 'Mẫu xe',
                        controller: vehicleTemplate,
                        inputType: TextInputType.text,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          validateFields();
                          ref
                              .read(vehicleRegisterNotifier.notifier)
                              .setVehicleRegisterName(value);
                        },
                        labelText: 'Tên mẫu xe*',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập tên mẫu xe';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildTextField(
                        // hint: 'Màu',
                        controller: vehicleColor,
                        inputType: TextInputType.text,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          validateFields();
                          ref
                              .read(vehicleRegisterNotifier.notifier)
                              .setVehicleRegisterColor(value);
                        },
                        labelText: 'Màu xe*',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập màu xe';
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
              // Navigator.pop(context);
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
              color: !isAllFieldsValid ? kOrange : kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
