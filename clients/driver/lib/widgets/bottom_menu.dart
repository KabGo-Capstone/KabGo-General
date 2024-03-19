import 'package:driver/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomMenu extends StatelessWidget {
  final Text label;
  final bool divider;
  final double height;
  final Widget widget;

  const BottomMenu({
    super.key,
    required this.label,
    this.height = double.infinity,
    this.divider = true, required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 0, top: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (divider)
            const SizedBox(
              width: 35,
              child: Row(
                children: [
                  WDivider(
                    height: 4,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          const SizedBox(height: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label,
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: widget
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
