import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchArea extends ConsumerWidget {
  const SearchArea(
      {super.key,
      required this.arrivalValue,
      required this.departureValue,
      required this.departureSearchFocus,
      required this.departureSearchState,
      required this.departureSuggestionList,
      required this.arrivalSearchFocus,
      required this.arrivalSearchState,
      required this.arrivalSuggestionList,
      required this.scrollToBottom,
      
      });
  final String arrivalValue;
  final String departureValue;
  final bool scrollToBottom;
  final Function(bool) departureSearchFocus;
  final Function(bool) departureSearchState;
  final Function(List<LocationModel>) departureSuggestionList;
  final Function(bool) arrivalSearchFocus;
  final Function(bool) arrivalSearchState;
  final Function(List<LocationModel>) arrivalSuggestionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: scrollToBottom
                ? const Color.fromARGB(255, 114, 114, 114).withOpacity(0.2)
                : Colors.white,
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
                    focus: departureSearchFocus,
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
                        color: Color(0xff006FD5),
                      ),
                    ),
                    placeHolder: 'Nhập điểm đón...',
                    value: departureValue,
                    search: departureSearchState,
                    suggestionList: departureSuggestionList,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  child: SearchInput(
                    focus: arrivalSearchFocus,
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
                        color: Color(0xffFA4848),
                      ),
                    ),
                    placeHolder: 'Nhập điểm đến...',
                    value: arrivalValue,
                    search: arrivalSearchState,
                    suggestionList: arrivalSuggestionList,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
