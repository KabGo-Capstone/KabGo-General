import 'dart:io';

import 'package:customer/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  dynamic navSelected = bottomNavs.first;
  double paddingDevice = Platform.isIOS ? 7 : 16;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, paddingDevice),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 216, 216, 216).withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ]),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              bottomNavs.length,
              (index) => InkWell(
                onTap: () {
                  navSelected = bottomNavs[index];
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: (MediaQuery.of(context).size.width - 10) / 5,
                  child: navSelected == bottomNavs[index]
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              bottomNavs[index]['solid-icon'] as String,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xffFE8248), BlendMode.srcIn),
                              width: (bottomNavs[index]['width'] as int)
                                  .toDouble(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              bottomNavs[index]['title'] as String,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFE8248),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              bottomNavs[index]['regular-icon'] as String,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xffA0A0A0), BlendMode.srcIn),
                              width: (bottomNavs[index]['width'] as int)
                                  .toDouble(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              bottomNavs[index]['title'] as String,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffA0A0A0),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
