import 'package:customer/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SuggestiionArrivalItem extends StatelessWidget {
  const SuggestiionArrivalItem({Key? key, required this.data})
      : super(key: key);
  final LocationModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 11, top: 12, left: 14, right: 5),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromARGB(255, 220, 220, 220)))),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 24,
            width: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffFE8248)),
            child: const FaIcon(
              // FontAwesomeIcons.locationDot,
              FontAwesomeIcons.locationDot,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
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
                width: MediaQuery.of(context).size.width * 0.7,
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
            size: 14,
          ),
        ],
      ),
    );
  }
}
