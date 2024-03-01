import 'package:customer/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HotLocation extends StatelessWidget {
  const HotLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Điểm đang hot trên KabGo',
                  style: Theme.of(context).textTheme.titleMedium),
              Container(
                height: 31,
                width: 31,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 254, 240, 235),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: Color.fromARGB(255, 70, 70, 70),
                  size: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...hotLocation.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0.9,
                          child: Container(
                            height: 105,
                            width: 145,
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xffFE8248),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 110,
                              width: 140,
                              decoration: BoxDecoration(
                                color: const Color(0xffFE8248),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(e['image'] as String),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            e['name'] as String,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 4),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 233, 239),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: const Text(
                                'Giảm 15%',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 197, 17, 50),
                                    fontSize: 10),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 4),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 233, 239),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: const Text(
                                'Tối đa 30k',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 197, 17, 50),
                                    fontSize: 10),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 216, 216, 216)
                          .withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: Color.fromARGB(255, 70, 70, 70),
                  size: 21,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
