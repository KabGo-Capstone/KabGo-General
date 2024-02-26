import 'package:customer/data/data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0xffFE8248),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/assets/avatar_image.jpg'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Khang Dinh',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '0976975549',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Hạng của bạn',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffFF772B),
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'lib/assets/user_rank.png',
                      width: 40,
                    )
                  ],
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 184, 143),
                      width: 1)),
              child: Column(
                children: [
                  ...menu_item.map(
                    (e) => GestureDetector(
                      onTap: () {
                        if (e != menu_item.last) {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 200),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        e['page'] as Widget,
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1, 0);
                                  const end = Offset.zero;

                                  final tween = Tween(begin: begin, end: end);

                                  return SlideTransition(
                                    position: tween.animate(animation),
                                    child: child,
                                  );
                                },
                              ));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22, horizontal: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: e == menu_item.last ? 0 : 1,
                                    color: const Color.fromARGB(
                                        255, 220, 220, 220)))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              e['icon'] as IconData,
                              color: const Color(0xffFF772B),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Text(
                              e['title'].toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            if (e != menu_item.last)
                              const FaIcon(
                                FontAwesomeIcons.angleRight,
                                color: Color(0xffFF772B),
                                size: 16,
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Column(
              children: [
                Image.asset(
                  'lib/assets/kabgo_logo.png',
                  scale: 1.4,
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  'The copyright 2024 by KabGo',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
