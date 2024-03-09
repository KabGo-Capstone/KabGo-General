import 'package:customer/models/location_model.dart';
import 'package:customer/screens/search/components/suggestion_area/components/recently_suggestions.dart';
import 'package:customer/screens/search/components/suggestion_area/components/search_suggestions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SuggestionArea extends ConsumerStatefulWidget {
  const SuggestionArea({
    Key? key,
    required this.searchState,
    required this.findDeparture,
    required this.scrollController,
    required this.suggestionLocationList,
    required this.departureChosen,
  }) : super(key: key);

  final bool searchState;
  final bool findDeparture;
  final ScrollController scrollController;
  final List<LocationModel> suggestionLocationList;
  final Function departureChosen;

  @override
  _SuggestionAreaState createState() => _SuggestionAreaState();
}

class _SuggestionAreaState extends ConsumerState<SuggestionArea> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: SingleChildScrollView(
              controller: widget.scrollController,
              child: widget.searchState
                  ? SearchSuggestions(
                      findDeparture: widget.findDeparture,
                      suggestionLocationList: widget.suggestionLocationList,
                      departureChosen: widget.departureChosen,
                    )
                  : RecentlySuggestions(widget.findDeparture))),
    );
  }
}
