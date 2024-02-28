import 'package:customer/data/data.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/widgets/recently_arrival_item.dart';
import 'package:customer/widgets/search_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool searchState = false;
  List<LocationModel> suggestionLocationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  _scrollListener() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      if (scrollToBottom) {
        setState(() {
          scrollToBottom = false;
        });
      }
    } else if (direction == ScrollDirection.reverse) {
      if (!scrollToBottom) {
        setState(() {
          scrollToBottom = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('===========> SEARCH_PAGE BUILD');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chọn địa điểm',
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0xffFE8248),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero, // Set this
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 9,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                // ref
                //     .read(mapProvider.notifier)
                //     .setMapAction('LOCATION_PICKER');
                // ref.read(stepProvider.notifier).setStep('location_picker');
                // ref
                //     .read(pickerLocationProvider.notifier)
                //     .setPickerLocation(ref.read(departureLocationProvider));
              },
              icon: const FaIcon(
                FontAwesomeIcons.mapLocationDot,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                'Bản đồ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: scrollToBottom
                      ? const Color.fromARGB(255, 114, 114, 114)
                          .withOpacity(0.2)
                      : Colors.white,
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'lib/assets/images/departure_icon.png',
                      width: 36,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SearchInput(
                        autoFocus: false,
                        placeHolder: 'Nhập điểm đón...',
                        value: 'Vị trí hiện tại',
                        search: (p0) {},
                        suggestionList: (p0) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'lib/assets/images/arrival_icon.png',
                      width: 36,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SearchInput(
                        autoFocus: true,
                        placeHolder: 'Nhập điểm đến...',
                        value: '',
                        search: (p0) {
                          setState(() {
                            searchState = p0;
                          });
                        },
                        suggestionList: (p0) {
                          setState(() {
                            suggestionLocationList = p0;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: searchState
                    ? suggestionLocationList.isNotEmpty
                        ? Column(
                            children: [
                              ...suggestionLocationList.map((e) {
                                e.structuredFormatting!.formatSecondaryText();
                                return InkWell(
                                  onTap: () {
                                    // ref
                                    //     .read(arrivalLocationProvider.notifier)
                                    //     .setArrivalLocation(e);
                                    // chooseArrival();
                                  },
                                  child: e.structuredFormatting!.secondaryText!
                                          .contains('TP.HCM')
                                      ? RecentlyArrivalItem(
                                          data: e,
                                        )
                                      : const SizedBox(),
                                );
                              })
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Không tìm thấy',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                    : Column(
                        children: [
                          ...recentlyArrivalData.map(
                            (e) => InkWell(
                              onTap: () {
                                // ref
                                //     .read(arrivalLocationProvider.notifier)
                                //     .setArrivalLocation(e);
                                // chooseArrival();
                              },
                              child: RecentlyArrivalItem(
                                data: e,
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
