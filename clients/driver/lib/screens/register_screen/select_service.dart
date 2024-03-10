import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/models/driver_service.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/service_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectService extends ConsumerStatefulWidget {
  const SelectService({super.key});

  @override
  ConsumerState<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends ConsumerState<SelectService> {
  late List<Service> services;
  late String selectedServiceId;
  String selectedService = 'Chọn 1 dịch vụ';
  bool isDataLoaded = false;
  late final String? idDriver;

  Future<void> fetchData() async {
    var data = json.encode({'otp': '123456'});
    try {
      final dioClient = DioClient();
      final response = await dioClient.request('/verify-user-registration',
          options: Options(method: 'POST'), data: data);

      if (response.statusCode == 200) {
        // final parsedResponse = json.decode(response.data);
        // final data = parsedResponse['data'];
        // print(response.data.runtimeType);
        // print(response.data['data'].runtimeType);
        // print(response.data['data']);
        setState(() {
          final List<dynamic> serviceListJson =
              response.data['data']['services'];
          services =
              serviceListJson.map((json) => Service.fromJson(json)).toList();
          isDataLoaded = true;
        });
      } else {
        // Xử lý lỗi nếu có
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleRegister() async {
    idDriver = ref.watch(driverInfoRegisterProvider).id;
    print(idDriver);
    var data = json.encode({'id': idDriver, 'serviceId': selectedServiceId});
    try {
      final dioClient = DioClient();

      final response = await dioClient.request(
        '/update-service',
        options: Options(method: 'POST'),
        data: data,
      );
      print(response.data);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoRegister(
              selectedService: selectedService,
            ),
          ),
        );

        // print(response.data['data']['id']);
      } else {
        // Xử lý lỗi nếu có
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: COLOR_WHITE,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
            ),
            onPressed: () {
              // Xử lý khi nút trở về được bấm
            },
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              print('Cần hỗ trợ');
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(0, 0)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
              side: MaterialStateProperty.all(const BorderSide(
                  color: Color.fromARGB(255, 97, 97, 97), width: 0.7)),
            ),
            child: const Text(
              'Cần hỗ trợ?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w100),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: GestureDetector(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildText(
                                'Chọn dịch vụ muốn đăng ký',
                                kBlackColor,
                                18,
                                FontWeight.w600,
                                TextAlign.start,
                                TextOverflow.clip,
                              ),
                              buildText(
                                'Vui lòng cho chúng tôi biết dịch vụ bạn muốn đăng ký là gì?',
                                kBlackColor,
                                12,
                                FontWeight.w400,
                                TextAlign.start,
                                TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Khoảng cách giữa chữ và hình ảnh
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/register/order_a_car.png',
                              // Đặt các thuộc tính của hình ảnh theo nhu cầu
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return ServiceBottomSheetWidget(
                                    services: services,
                                    onServiceSelected: (selectedService) {
                                      setState(() {
                                        this.selectedService =
                                            selectedService.name;
                                        selectedServiceId = selectedService.id;
                                        print(
                                            'Selected service ID: ${selectedService.id}');
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 42, 41, 41),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(selectedService),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: selectedService != 'Chọn 1 dịch vụ'
              ? () {
                  debugPrint(selectedService);

                  handleRegister();
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (selectedService != 'Chọn 1 dịch vụ') {
                return kOrange;
              } else {
                return const Color.fromARGB(255, 240, 240, 240);
              }
            }),
          ),
          child: Text(
            'Tiếp tục',
            style: TextStyle(
              fontSize: 16,
              color:
                  selectedService == 'Chọn 1 dịch vụ' ? kOrange : kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
