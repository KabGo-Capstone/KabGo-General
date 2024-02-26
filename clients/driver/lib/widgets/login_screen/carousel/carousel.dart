import 'package:driver/widgets/login_screen/carousel/indicator.dart';
import 'package:driver/widgets/login_screen/carousel/slider.dart';
import 'package:flutter/material.dart';

const items = [
  {
    'image': 'assets/images/login/carousel/step-1.png',
    'description':
        'Bạn đã sẵn sàng khám phá hành trình linh hoạt và tăng thu nhập?'
  },
  {
    'image': 'assets/images/login/carousel/step-2.png',
    'description':
        'Chúng tôi sẵn lòng hỗ trợ bạn trên con đường lái xe thành công.'
  },
  {
    'image': 'assets/images/login/carousel/step-3.png',
    'description':
        'Hãy cùng nhau khởi động và tận hưởng trải nghiệm lái xe đáng giá nhé!'
  }
];

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CSlider(
          items: items,
          onPageChanged: (index, reason) => {
            setState(() {
              activeIndex = index;
            }),
          },
        ),
        const SizedBox(height: 18),
        CIndicator(activeIndex: activeIndex, count: items.length),
      ],
    );
  }
}
