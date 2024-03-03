import 'package:driver/constants/colors.dart';
import 'package:driver/data/data.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/widgets/build_text.dart';
import 'package:driver/widgets/service_bottomsheet.dart';
import 'package:flutter/material.dart';

class SelectService extends StatefulWidget {
  const SelectService({super.key});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  String selectedService = 'Chọn 1 dịch vụ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: COLOR_WHITE,
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
              style: TextStyle(color: Colors.black),
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
                                        this.selectedService = selectedService;
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
          onPressed: () {
            // Add your confirmation logic here
            debugPrint('Xác nhận');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InfoRegister(selectedService: selectedService),
              ),
            );
          },
          child: const Text(
            'Tiếp tục',
            style: TextStyle(
              fontSize: 16,
              color: kOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
