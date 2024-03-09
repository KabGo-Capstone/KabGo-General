import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapPicker extends StatelessWidget {
  const MapPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 170,
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Xin chào,',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 232, 223),
                      minimumSize: Size.zero, // Set this
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 9,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.mapLocationDot,
                      color: Colors.black,
                      size: 18,
                    ),
                    label: const Text(
                      'Bản đồ',
                      style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Đinh Nguyễn Duy Khang',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                ),
                Expanded(
                  child: Image.asset(
                    'lib/assets/images/home_page_background.png',
                    height: MediaQuery.of(context).size.width * 0.235,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
