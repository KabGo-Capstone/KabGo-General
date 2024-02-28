import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/location_model.dart';

class RecentlyArrivalItem extends StatelessWidget {
  const RecentlyArrivalItem({super.key, required this.data});

  final LocationModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 11, top: 12, left: 6, right: 5),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromARGB(255, 220, 220, 220)))),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'lib/assets/images/arrival_icon.png',
            width: 25,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 295,
                child: Text(
                  data.structuredFormatting!.mainText.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  '${data.structuredFormatting!.mainText.toString()}, ${data.structuredFormatting!.secondaryText.toString()}',
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          const FaIcon(
            FontAwesomeIcons.arrowRight,
            color: Color.fromARGB(255, 70, 70, 70),
            size: 18,
          ),
        ],
      ),
    );
  }
}
