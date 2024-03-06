import 'package:customer/data/data.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/widgets/current_location_item.dart';
import 'package:customer/widgets/saved_location_item.dart';
import 'package:customer/widgets/recently_arrival_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../models/location_model.dart';

class RecentlySuggestions extends ConsumerStatefulWidget {
  const RecentlySuggestions(this.findDeparture, {Key? key}) : super(key: key);
  final bool findDeparture;

  @override
  _RecentlySuggestionsState createState() => _RecentlySuggestionsState();
}

class _RecentlySuggestionsState extends ConsumerState<RecentlySuggestions> {
  int optionState = 1;
  List<LocationModel> suggestionData = recentlyArrivalData;
  LocationModel? currentLocation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLocation = ref.read(departureLocationProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (optionState != 1) {
                  optionState = 1;
                  suggestionData = recentlyArrivalData;
                  setState(() {});
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                    color: optionState == 1
                        ? const Color.fromARGB(255, 255, 245, 239)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: Text(
                  'Dùng gần đây',
                  style: TextStyle(
                      color: optionState == 1
                          ? const Color.fromARGB(255, 218, 99, 44)
                          : const Color.fromARGB(255, 110, 110, 110),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                if (optionState != 2) {
                  optionState = 2;
                  suggestionData = proposalArrivalData;
                  setState(() {});
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                    color: optionState == 2
                        ? const Color.fromARGB(255, 255, 245, 239)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: Text(
                  'Đề xuất',
                  style: TextStyle(
                      color: optionState == 2
                          ? const Color.fromARGB(255, 218, 99, 44)
                          : const Color.fromARGB(255, 110, 110, 110),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                if (optionState != 3) {
                  optionState = 3;
                  setState(() {});
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                    color: optionState == 3
                        ? const Color.fromARGB(255, 255, 245, 239)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: Text(
                  'Đã lưu',
                  style: TextStyle(
                      color: optionState == 3
                          ? const Color.fromARGB(255, 218, 99, 44)
                          : const Color.fromARGB(255, 110, 110, 110),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
        if (optionState != 3)
          Column(
            children: [
              if (widget.findDeparture)
                CurrentLocationItem(currentLocation: currentLocation!),
              ...suggestionData.map(
                (e) => InkWell(
                  onTap: () {
                    // ref
                    //     .read(arrivalLocationProvider.notifier)
                    //     .setArrivalLocation(e);
                    // chooseArrival();
                  },
                  child: RecentlyArrivalItem(
                    padding: 14,
                    data: e,
                  ),
                ),
              )
            ],
          )
        else
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    bottom: 15, top: 16, left: 12, right: 5),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 220, 220, 220)))),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 28,
                      width: 28,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 242, 242, 242)),
                      child: const FaIcon(
                        FontAwesomeIcons.plus,
                        size: 18,
                        color: Color.fromARGB(255, 0, 202, 64),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Thêm',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              ...favoriteLocationData.take(favoriteLocationData.length - 1).map(
                    (e) => InkWell(
                      onTap: () {},
                      child: SavedLocationItem(
                        data: e,
                      ),
                    ),
                  ),
            ],
          ),
                  const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
