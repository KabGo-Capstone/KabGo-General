import 'package:driver/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetSelector extends StatelessWidget {
  final List<String> options;
  final void Function(String) onSelected;
  final Text label;
  final bool divider;
  final double height;

  const BottomSheetSelector({
    super.key,
    required this.onSelected,
    required this.options,
    required this.label,
    this.height = double.infinity,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 12),
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
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final option = options[index];
                            return InkWell(
                              onTap: () {
                                onSelected(option);
                                context.pop();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  if (index < options.length - 1)
                                    const Divider(color: Colors.black12)
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
