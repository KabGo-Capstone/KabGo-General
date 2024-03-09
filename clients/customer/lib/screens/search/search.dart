import 'dart:io';

import 'package:customer/data/data.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/widgets/recently_arrival_item.dart';
import 'package:customer/widgets/search_input.dart';
import 'package:customer/widgets/suggestiion_arrival_item.dart';
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
  bool keyboardAppearance = false;
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
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: scrollToBottom ? const Color.fromARGB(255, 114, 114, 114).withOpacity(0.2) : Colors.white,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(right: 10),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Color(0xffFE8248),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                          child: SearchInput(
                            focus: (p0) {
                              Future.delayed(const Duration(milliseconds: 200), () {
                                keyboardAppearance = p0;
                                setState(() {});
                              });
                            },
                            icon: Container(
                              width: 18,
                              height: 18,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.solidCircleDot,
                                size: 16,
                                color: Color(0xff4F96FF),
                              ),
                            ),
                            placeHolder: 'Nhập điểm đón...',
                            value: 'Vị trí hiện tại',
                            search: (p0) {},
                            suggestionList: (p0) {},
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: SearchInput(
                            focus: (p0) {
                              Future.delayed(const Duration(milliseconds: 200), () {
                                keyboardAppearance = p0;
                                setState(() {});
                              });
                            },
                            icon: Container(
                              width: 18,
                              height: 18,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.solidCircleDot,
                                size: 16,
                                color: Color(0xffED6C66),
                              ),
                            ),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 50),
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
                                    child: e.structuredFormatting!.secondaryText!.contains('TP.Hồ Chí Minh')
                                        ? SuggestiionArrivalItem(
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
                                  style: Theme.of(context).textTheme.titleMedium,
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
                                  padding: 14,
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
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(
            bottom: keyboardAppearance
                ? 10
                : Platform.isIOS
                    ? 40
                    : 20,
            top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 216, 216, 216).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.mapLocationDot,
              color: Colors.black,
              size: 16,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Chọn từ bản đồ',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
