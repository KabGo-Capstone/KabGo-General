import 'package:customer/data/data.dart';
import 'package:customer/widgets/favorite_location_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteLocation extends StatelessWidget {
  const FavoriteLocation({
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
              Text('Các địa điểm yêu thích',
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
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favoriteLocationData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: index != favoriteLocationData.length - 1
                      ? InkWell(
                          onTap: () {
                            // ref
                            //     .read(arrivalLocationProvider
                            //         .notifier)
                            //     .setArrivalLocation(
                            //         favoriteLocationData[index]
                            //                 ['location']
                            //             as LocationModel);
                            // chooseArrival();
                          },
                          child: FavoriteLocationItem(
                            data: favoriteLocationData[index],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            print('tappppp');
                          },
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 56,
                                width: 56,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 245, 239),
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Align(
                                        child: favoriteLocationData[index]
                                            ['icon'] as Widget),
                                    Positioned(
                                      left: 36,
                                      top: 36,
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 216, 216, 216)
                                                  .withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0, 5),
                                            )
                                          ],
                                        ),
                                        child: const FaIcon(
                                          FontAwesomeIcons.plus,
                                          size: 14,
                                          color:
                                              Color.fromARGB(255, 27, 118, 255),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                favoriteLocationData[index]['title'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              }),
        ),
      ],
    );
  }
}
