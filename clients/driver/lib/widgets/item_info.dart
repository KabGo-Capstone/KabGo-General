import 'package:driver/constants/colors.dart';
import 'package:flutter/material.dart';

class ItemInfo extends StatefulWidget {
  final String? title;
  final bool? isCompleted;
  const ItemInfo({super.key, required this.isCompleted, required this.title});

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: COLOR_GRAY, width: 0.5)), // Border bottom
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title!,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                widget.isCompleted! ? 'Đã hoàn tất' : 'Bắt buộc',
                style: TextStyle(
                  color: widget.isCompleted! ? Colors.green : kOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.arrow_right_alt,
                color: widget.isCompleted! ? Colors.green : kOrange,
              )
            ],
          )
        ],
      ),
    );
  }
}
