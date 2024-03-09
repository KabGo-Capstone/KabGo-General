import 'package:customer/models/location_model.dart';
import 'package:customer/widgets/find_from_map_button.dart';
import 'package:customer/screens/search/components/search_area.dart';
import 'package:customer/screens/search/components/suggestion_area/suggestion_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Search extends ConsumerStatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final _scrollController = ScrollController();
  bool scrollToBottom = false;
  bool searchState = false;
  bool keyboardAppearance = false;
  bool findDeparture = false;
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
              SearchArea(
                scrollToBottom: scrollToBottom,
                departureSearchFocus: (p0) {
                  searchState = false;
                  findDeparture = true;
                  keyboardAppearance = p0;
                  setState(() {});
                },
                departureSearchState: (p0) {
                  setState(() {
                    searchState = p0;
                  });
                },
                departureSuggestionList: (p0) {
                  setState(() {
                    suggestionLocationList = p0;
                  });
                },
                arrivalSearchFocus: (p0) {
                  searchState = false;
                  findDeparture = false;
                  keyboardAppearance = p0;
                  setState(() {});
                },
                arrivalSearchState: (p0) {
                  setState(() {
                    searchState = p0;
                  });
                },
                arrivalSuggestionList: (p0) {
                  setState(() {
                    suggestionLocationList = p0;
                  });
                },
              ),
              SuggestionArea(
                searchState: searchState,
                findDeparture: findDeparture,
                scrollController: _scrollController,
                suggestionLocationList: suggestionLocationList,
              ),
            ],
          ),
        ),
        bottomSheet: FindFromMapButton(
          keyboardAppearance: keyboardAppearance,
        ));
  }
}
