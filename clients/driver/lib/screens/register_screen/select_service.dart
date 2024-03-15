import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/models/driver_service.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/bottom_selector.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectService extends ConsumerStatefulWidget {
  static String path = '/service/select';
  static String name = 'select_service';

  const SelectService({super.key});

  @override
  ConsumerState<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends ConsumerState<SelectService> {
  late List<Service> services = [];
  late Service selectedService = Service('', '');

  bool isDataLoaded = false;
  late String? idDriver;

  late bool isValid = false;

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
          for (var json in serviceListJson) {
            services.add(Service.fromJson(json));
          }
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
    final idDriver = ref.watch(driverInfoRegisterProvider).id;
    print(idDriver);
    var data = json.encode({'id': idDriver, 'serviceId': selectedService.id});
    try {
      final dioClient = DioClient();

      final response = await dioClient.request(
        '/update-service',
        options: Options(method: 'POST'),
        data: data,
      );
      print(response.data);

      if (response.statusCode == 200) {
        SharedPreferences.getInstance().then((prefs) {
          final userProfile = prefs.getString('user-profile')!;
          final userProfileMap = jsonDecode(userProfile);

          userProfileMap['serviceID'] = selectedService.id;

          prefs.setString('user-profile', jsonEncode(userProfileMap));

          context.pushNamed(InfoRegister.name);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  openServiceSelector() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return BottomSheetSelector(
          height: (100.0 + (56.0 * services.length)),
          label: const Text(
            'Chọn thành phố',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          options: services.map((e) => e.name).toList(),
          onSelected: (selectedOption) {
            print(selectedOption);

            setState(() {
              final serviceIndex = services
                  .indexWhere((element) => element.name == selectedOption);
              if (serviceIndex != -1) {
                selectedService = services[serviceIndex];
                isValid = selectedService.id.isNotEmpty &&
                    selectedService.name.isNotEmpty;
              }
            });
          },
        );
      },
    );
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
                            onTap: openServiceSelector,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 219, 219, 219),
                                  width: 1.0,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 14,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      selectedService.name.isEmpty
                                          ? 'Thành phố*'
                                          : selectedService.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: selectedService.name.isEmpty
                                            ? Colors.black54
                                            : Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    const FaIcon(
                                      FontAwesomeIcons.chevronRight,
                                      size: 12,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(width: 4),
                                  ],
                                ),
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
        child: WButton(
          width: double.infinity,
          radius: 50,
          shadow: const BoxShadow(
            color: Colors.transparent,
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 63, 63, 63),
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0,
            alignment: Alignment.center,
          ),
          onPressed: isValid ? handleRegister : null,
          child: Text(
            'Tiếp tục',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isValid ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
