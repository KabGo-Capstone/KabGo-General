import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class CIndicator extends StatelessWidget {
  final int activeIndex;
  final int count;

  const CIndicator({super.key, required this.activeIndex, required this.count});

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect: ExpandingDotsEffect(
        activeDotColor: Theme.of(context).primaryColor,
        dotColor: const Color(0xFFFFF4EF),
        dotHeight: 6,
        dotWidth: 6,
        spacing: 9,
      ),
    );
  }
}
