import 'package:carousel_slider/carousel_slider.dart';
import 'package:driver/widgets/login_screen/carousel/item.dart';
import 'package:flutter/material.dart';

class CSlider extends StatelessWidget {
  final List<Map<String, String>> items;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  const CSlider({super.key, required this.items, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 340,
        viewportFraction: 1,
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
      items: items.map((el) {
        return SItem(image: el.values.first, description: el.values.last);
      }).toList(),
    );
  }
}
