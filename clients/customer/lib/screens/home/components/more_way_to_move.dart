import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MoreWayToMove extends StatelessWidget {
  const MoreWayToMove({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text('Thêm nhiều cách để di chuyển', style: Theme.of(context).textTheme.titleMedium),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          height: 90,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 208, 233),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'lib/assets/images/group_people.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vi vu cùng bạn bè ngay',
                              style: TextStyle(color: Colors.black, fontSize: 13),
                            ),
                            Expanded(
                              child: Text(
                                'Thêm lên đến 4 điểm dừng',
                                maxLines: 2,
                                style: TextStyle(color: Colors.black, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 233, 223),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'lib/assets/images/driver_icon.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Thuê xe theo giờ',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
