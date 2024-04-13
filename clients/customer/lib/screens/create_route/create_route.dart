import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/create_route/components/complete_panel/complete_panel.dart';
import 'package:customer/screens/create_route/components/wait_driver_panel/wait_driver_panel.dart';
import 'package:customer/screens/create_route/components/widgets/arrival_location_picker.dart';
import 'package:customer/screens/create_route/components/widgets/book_car_panel.dart';
import 'package:customer/screens/create_route/components/widgets/car_selection_panel.dart';
import 'package:customer/screens/create_route/components/widgets/current_location_widget.dart';
import 'package:customer/screens/create_route/components/widgets/departure_location_picker.dart';
import 'package:customer/screens/create_route/components/find_driver/find_driver_screen.dart';
import 'package:customer/screens/create_route/components/widgets/location_picker_widget.dart';
import 'package:customer/screens/create_route/components/widgets/route_information_widget.dart';
import 'package:customer/screens/create_route/components/widgets/my_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CreateRoute extends ConsumerStatefulWidget {
  const CreateRoute({Key? key}) : super(key: key);

  @override
  _ArrivalLocationPickerState createState() => _ArrivalLocationPickerState();
}

class _ArrivalLocationPickerState extends ConsumerState<CreateRoute> {
  Widget bottomDialog = const SizedBox();

  bool locationPicker = false;
  bool currentLocation = true;

  Widget bottomPanel = const SizedBox();
  double minHeightPanel = 0;
  double maxHeightPanel = 0;

  final PanelController panelController = PanelController();
  final PanelController bottomController = PanelController();

  double bottomPadding = 0.25;
  double heightIconPicker = 44;

  bool bottomNavigationBar = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('CREATE_ROUTE_REBUILD');

    final screenSize = MediaQuery.of(context).size;

    String step = ref.watch(stepProvider);
    if (step == 'arrival_location_picker') {
      bottomPadding = 0.25;
      bottomDialog = const ArrivalLocationPicker();
      locationPicker = true;
      setState(() {});
    } else if (step == 'departure_location_picker') {
      bottomPadding = 0.3;
      bottomDialog = const DepartureLocationPicker();
      locationPicker = true;
      setState(() {});
    } else if (step == 'create_trip') {
      locationPicker = false;
      currentLocation = false;
      bottomDialog = const SizedBox();
      minHeightPanel = screenSize.height * 0.45;
      maxHeightPanel = screenSize.height * 0.65;
      setState(() {});
    } else if (step == 'find_driver') {
      minHeightPanel = screenSize.height * 0.15;
      maxHeightPanel = screenSize.height * 0.38;
      bottomPanel = const FindDriver();
      setState(() {});
    } else if (step == 'wait_driver') {
      bottomNavigationBar = true;
      minHeightPanel = screenSize.height * 0.26;
      maxHeightPanel = screenSize.height * 0.6;
      bottomPanel = const WaitDriverPanel();
      setState(() {});
    } else if (step == 'comming_driver') {
    } else if (step == 'moving') {
    } else if (step == 'complete') {
      minHeightPanel = 0;
      maxHeightPanel = 0;
      bottomDialog = const CompletePanel();
    }

    return Scaffold(
      body: Stack(
        children: [
          const MyMap(),
          if (currentLocation)
            CurrentLocationWidget(bottomPadding: bottomPadding),
          if (locationPicker)
            LocationPickerWidget(heightIconPicker: heightIconPicker),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomDialog,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlidingUpPanel(
              minHeight: minHeightPanel,
              maxHeight: maxHeightPanel,
              color: Colors.transparent,
              defaultPanelState: PanelState.CLOSED,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(80, 217, 217, 217),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(1, 0),
                ),
              ],
              panelBuilder: (sc) => bottomPanel,
            ),
          ),
          if (ref.read(stepProvider) == 'create_trip')
            const RouteInformationWidget(),
          if (ref.read(stepProvider) == 'create_trip')
            CarSelectionPanel(
                bottomController: bottomController,
                panelController: panelController,
                minHeightPanel: minHeightPanel,
                maxHeightPanel: maxHeightPanel),
          if (ref.read(stepProvider) == 'create_trip')
            BookCarPanel(bottomController: bottomController),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar
          ? (ref.read(stepProvider) == 'wait_driver' ||
                  ref.read(stepProvider) == 'comming_driver')
              ? Container(
                  color: Colors.white,
                  child: SafeArea(
                    child: Container(
                      height: (ref.read(stepProvider) == 'wait_driver' ||
                              ref.read(stepProvider) == 'comming_driver')
                          ? 80
                          : 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 15),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color(0xffEAEAEA), // Màu của border top
                            width: 1, // Độ dày của border top
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 54,
                            height: 54,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const FaIcon(
                                FontAwesomeIcons.solidComment,
                                color: Color(0xffFE8248),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 54,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff29BD11)),
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.phone,
                                  size: 21,
                                  color: Colors.white,
                                ),
                                label: Text('gọi điện'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(color: Color(0xffFE8248)),
                  child: SafeArea(
                    child: Container(
                      height: (ref.read(stepProvider) == 'moving') ? 80 : 0,
                      alignment: Alignment.center,
                      child: const Text(
                        'Đang di chuyển',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
          : const SizedBox(),
    );
  }
}
