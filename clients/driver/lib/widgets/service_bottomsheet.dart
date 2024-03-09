import 'package:flutter/material.dart';

class ServiceBottomSheetWidget extends StatelessWidget {
  final List<String> services;
  final void Function(String) onServiceSelected;

  const ServiceBottomSheetWidget({
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
            'Choose a Service',
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
                  child: Text(
                    service,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
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
