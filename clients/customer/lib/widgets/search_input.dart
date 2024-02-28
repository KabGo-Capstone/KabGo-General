import 'package:customer/functions/networkUtility.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/models/place_auto_complate_response.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/utils/Google_Api_Key.dart';
import 'package:customer/widgets/suggestion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchInput extends StatefulWidget {
  const SearchInput(
      {Key? key,
      required this.placeHolder,
      required this.value,
      required this.autoFocus,
      required this.search,
      required this.suggestionList})
      : super(key: key);

  final String placeHolder;
  final String value;
  final bool autoFocus;
  final Function(bool) search;
  final Function(List<LocationModel>) suggestionList;

  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<SearchInput> {
  final inputController = TextEditingController();
  String? _value;

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
    super.initState();
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
            autofocus: widget.autoFocus,
            controller: inputController,
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) {
              if (value.length <= 1) {
                if(value.length==1){
                  widget.search(true);
                }
                if(value.isEmpty){
                  widget.search(false);
                }
                setState(() {});
              }
            },
            decoration: InputDecoration(
              suffixIcon: inputController.text.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            inputController.clear();
                            widget.search(false);
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Color.fromARGB(255, 106, 106, 106),
                            size: 21,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: 1,
                    ),
              hintText: widget.placeHolder,
              hintStyle: Theme.of(context).textTheme.labelSmall,
              contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              fillColor: const Color.fromARGB(255, 249, 249, 249),
              filled: true,
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
            print(matches.length);
            return matches;
          },
        );
      },
    );
  }
}
