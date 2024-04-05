import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/constants/colors.dart';
import 'package:driver/firebase/auth/google_sign_in.dart';
import 'package:driver/models/driver_service.dart';
import 'package:driver/providers/driver_info_register.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/services/dio_client.dart';
import 'package:driver/widgets/bottom_menu.dart';
import 'package:driver/widgets/bottom_selector.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/button.dart';
import 'package:driver/widgets/divider.dart';
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

  late bool isValid = false;

  Future<void> fetchData() async {
    try {
      final dioClient = DioClient();
      final response = await dioClient.request('/verify-user-registration',
          options: Options(method: 'POST'), data: {});

      if (response.statusCode == 200) {
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
    fetchData().then((value) {
      SharedPreferences.getInstance().then((prefs) {
        final userProfileJson = prefs.getString('user-profile');
        final userProfile = jsonDecode(userProfileJson!);

        print(userProfile);

        final serviceIndex = services
            .indexWhere((element) => element.id == userProfile['serviceID']);
        if (serviceIndex >= 0) {
          setState(() {
            selectedService = services[serviceIndex];
            isValid = true;
          });
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleSignOut() {
    GoogleSignInController.signOut().then((value) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.clear().then((value) {
          context.go(LoginScreen.path);
        });
      });
    });
  }

  handleRegister() async {
    final idDriver = ref.watch(driverInfoRegisterProvider).id;
    var data = json.encode({'id': idDriver, 'serviceId': selectedService.id});
    try {
      final dioClient = DioClient();

      final response = await dioClient.request(
        '/update-service',
        options: Options(method: 'POST'),
        data: data,
      );

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

  openMenu() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return BottomMenu(
          height: (100.0 + (41.0 * 3)),
          label: const Text(
            'Hành động',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          widget: Column(
            children: [
              const Divider(
                height: 0.5,
                color: Colors.black12,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: handleSignOut,
                  child: const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.powerOff,
                        size: 18,
                        color: Color.fromARGB(255, 216, 62, 51),
                      ),
                      SizedBox(width: 13),
                      Text(
                        'Đăng xuất',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 216, 62, 51),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: WButton(
                  width: double.infinity,
                  radius: 50,
                  shadow: const BoxShadow(
                    color: Colors.transparent,
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black12,
                    backgroundColor: Colors.black12,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Đóng',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Image(
          image: AssetImage('assets/logo-hori.png'),
          width: 110,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: openMenu,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FaIcon(FontAwesomeIcons.ellipsisVertical),
                  ),
                )
              ],
            ),
          ),
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
                                'Chọn dịch vụ đăng ký',
                                kBlackColor,
                                20,
                                FontWeight.w600,
                                TextAlign.start,
                                TextOverflow.clip,
                              ),
                              const SizedBox(height: 8),
                              buildText(
                                'Vui lòng chọn dịch vụ bạn muốn đăng ký.',
                                kBlackColor,
                                12,
                                FontWeight.w400,
                                TextAlign.start,
                                TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                                'assets/images/register/order_a_car.png'),
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
                                          ? 'Loại dịch vụ'
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
