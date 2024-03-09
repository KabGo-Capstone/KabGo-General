import 'package:customer/functions/networkUtility.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/models/place_auto_complate_response.dart';
import 'package:customer/utils/Google_Api_Key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchInput extends StatefulWidget {
  const SearchInput(
      {super.key,
      required this.placeHolder,
      required this.value,
      required this.search,
      required this.suggestionList,
      required this.icon,
      required this.focus});

  final String placeHolder;
  final String value;
  final Widget icon;
  final Function(bool) focus;
  final Function(bool) search;
  final Function(List<LocationModel>) suggestionList;

  @override
  // ignore: library_private_types_in_public_api
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<SearchInput> {
  final inputController = TextEditingController();
  String? _value;
  FocusNode _searchFocus = FocusNode();

  Future<List<LocationModel>> placeAutoComplete(String query) async {
    List<LocationModel> placePredictions = [];
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      'input': query,
      'key': APIKey,
      'components': 'country:vn',
      'city': 'Ho Chi Minh City',
      'locationbias': 'circle:5000@10.791043518001057, 106.64709564391066',
      'language': 'vi',
    });

    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        placePredictions = result.predictions!;
      }
    }
    return placePredictions;
  }

  @override
  void initState() {
    _value = widget.value;
    inputController.text = widget.value;
    _searchFocus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocus.removeListener(_onFocusChange);
    _searchFocus.dispose();
  }

  void _onFocusChange() {
    widget.focus(_searchFocus.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    print('===========> SEARCH_INPUT BUILD');

    if (widget.value.isNotEmpty && _value!.isEmpty) {
      inputController.text = widget.value;
      _value = widget.value;
    }
    return Consumer(
      builder: (context, ref, child) {
        return TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: inputController,
            style: _searchFocus.hasFocus
                ? Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w700)
                : Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
            onChanged: (value) {
              if (value.length <= 1) {
                if (value.length == 1) {
                  widget.search(true);
                }
                if (value.isEmpty) {
                  widget.search(false);
                }
                setState(() {});
              }
            },
            focusNode: _searchFocus,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon,
                ],
              ),
              suffixIcon:
                  inputController.text.isNotEmpty && _searchFocus.hasFocus
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                inputController.clear();
                                widget.search(false);
                              },
                              child: Container(
                                width: 18,
                                height: 18,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 191, 191, 191),
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.xmark,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: 1,
                        ),
              hintText: widget.placeHolder,
              hintStyle: Theme.of(context).textTheme.labelSmall,
              contentPadding: const EdgeInsets.all(0),
              fillColor: const Color.fromARGB(255, 249, 249, 249),
              filled: true,
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
              ),
            ),
          ),
          animationStart: 0,
          animationDuration: Duration.zero,
          noItemsFoundBuilder: (context) => const SizedBox(),
          hideOnLoading: true,
          onSuggestionSelected: (suggestion) {},
          itemBuilder: (ctx, suggestion) => const SizedBox(),
          suggestionsCallback: (pattern) async {
            List<LocationModel> matches = await placeAutoComplete(pattern);
            widget.suggestionList(matches);
            return matches;
          },
        );
      },
    );
  }
}
