import 'package:driver/constants/colors.dart';
import 'package:driver/models/driver_service.dart';
import 'package:flutter/material.dart';

class ServiceBottomSheetWidget extends StatelessWidget {
  final List<Service> services;
  final void Function(Service) onServiceSelected;

  const ServiceBottomSheetWidget({
    super.key,
    required this.services,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Chọn 1 dịch vụ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return InkWell(
                onTap: () {
                  onServiceSelected(service);
                  Navigator.pop(context); // Đóng BottomSheet sau khi chọn
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.only(
                        bottom: 8), // Khoảng cách đường viền dưới
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey
                              .withOpacity(0.5), // Màu đường viền và độ mờ
                          width: 1, // Độ dày của đường viền
                        ),
                      ),
                    ),
                    child: Text(
                      service
                          .name, // Truy cập vào thuộc tính name của đối tượng Service
                      style: const TextStyle(
                        fontSize: 16,
                        color: COLOR_TEXT_MAIN,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
