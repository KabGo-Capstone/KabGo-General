import 'package:customer/models/location_model.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/create_route/components/arrival_location_picker.dart';
import 'package:customer/screens/create_route/components/departure_location_picker.dart';
import 'package:customer/widgets/current_location_button.dart';
import 'package:customer/screens/create_route/components/my_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CreateRoute extends ConsumerStatefulWidget {
  const CreateRoute({Key? key}) : super(key: key);

  @override
  _ArrivalLocationPickerState createState() => _ArrivalLocationPickerState();
}

class _ArrivalLocationPickerState extends ConsumerState<CreateRoute> {
  double minHeightPanel = 0;
  double maxHeightPanel = 0;

  bool locationPicker = false;

  Widget bottomPanel = Container();

  final PanelController panelController = PanelController();

  LocationModel? departure;
  double bottomPadding = 0.25;
  double heightIconPicker = 44;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    departure = ref.read(departureLocationProvider);
  }

  @override
  Widget build(BuildContext context) {
    if (ref.read(stepProvider) == 'arrival_location_picker') {
      bottomPanel = const ArrivalLocationPicker();
      locationPicker = true;
    } else if (ref.read(stepProvider) == 'departure_location_picker') {
      bottomPanel = const DepartureLocationPicker();
      locationPicker = true;
    }

    return Consumer(
      builder: (context, ref, child) {
        ref.listen(stepProvider, (previous, next) {
          setState(() {
            if (next == 'arrival_location_picker') {
              bottomPadding = 0.25;
              bottomPanel = const ArrivalLocationPicker();
              locationPicker = true;
            } else if (next == 'departure_location_picker') {
              bottomPadding = 0.3;
              bottomPanel = const DepartureLocationPicker();
              locationPicker = true;
            } else if (next == 'create_trip') {
            } else if (next == 'find_driver') {
            } else if (next == 'wait_driver') {
            } else if (next == 'comming_driver') {
            } else if (next == 'moving') {
            } else if (next == 'complete') {}
          });
        });
        return Scaffold(
          body: SlidingUpPanel(
            controller: panelController,
            minHeight: minHeightPanel,
            maxHeight: maxHeightPanel,
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(80, 217, 217, 217),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(1, 0),
              ),
            ],
            // parallaxOffset: 0.5,
            body: Stack(
              children: [
                const MyMap(),
                ////////////////////////////////////////////////////// LOCATION BUTTON
                AnimatedAlign(
                  duration: const Duration(milliseconds: 40),
                  alignment: Alignment(0.92, 0.95 - bottomPadding * 2),
                  child: CurrentLocationButton(getCurrentLocation: () {
                    ref
                        .read(mapProvider.notifier)
                        .setMapAction('get_current_location');
                  }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: bottomPanel,
                ),
                if (locationPicker)
                  Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: 175 + heightIconPicker / 2),
                      child: Image.asset(
                        ref.read(stepProvider) == 'departure_location_picker'
                            ? 'lib/assets/images/map_departure_icon.png'
                            : 'lib/assets/images/map_arrival_icon.png',
                        height: heightIconPicker,
                      ),
                    ),
                  ),
              ],
            ),
            panelBuilder: (sc) => Container(),
          ),
        );
      },
    );
  }
}
