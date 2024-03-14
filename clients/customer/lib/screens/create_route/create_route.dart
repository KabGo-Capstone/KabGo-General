import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/create_route/components/arrival_location_picker.dart';
import 'package:customer/screens/create_route/components/book_car/book_car.dart';
import 'package:customer/screens/create_route/components/book_car/choose_payment_method.dart';
import 'package:customer/screens/create_route/components/book_car/discount_page.dart';
import 'package:customer/screens/create_route/components/departure_location_picker.dart';
import 'package:customer/widgets/bottom_button.dart';
import 'package:customer/widgets/current_location_button.dart';
import 'package:customer/screens/create_route/components/my_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool currentLocation = true;

  Widget bottomPanel = const SizedBox();
  Widget panelBuilder = const SizedBox();

  final PanelController panelController = PanelController();

  LocationModel? departure;
  double bottomPadding = 0.25;
  double heightIconPicker = 44;

  String paymentMethod = 'Tiền mặt';
  String paymentImage = 'lib/assets/images/cash_icon.png';
  String discount = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    departure = ref.read(departureLocationProvider);
  }

  void showPaymentMethod(StateSetter stateSetter) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) => ChoosePaymentMethod((int value) {
              stateSetter(
                () {
                  if (value == 1) {
                    paymentMethod = 'Tiền mặt';
                    paymentImage = 'lib/assets/images/cash_icon.png';
                  } else if (value == 2) {
                    paymentMethod = 'Thẻ ngân hàng';
                    paymentImage = 'lib/assets/images/master_card_icon.png';
                  } else if (value == 3) {
                    paymentMethod = 'ZaloPay';
                    paymentImage = 'lib/assets/images/zalo_pay_icon.png';
                  }
                },
              );
            }));
  }

  void showDiscountList(StateSetter stateSetter) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) => DiscountPage(chooseItem: (String value) {
              stateSetter(
                () {
                  discount = value;
                },
              );
            }));
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

    final screenSize = MediaQuery.of(context).size;

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
              locationPicker = false;
              currentLocation = false;
              bottomPanel = const SizedBox();
              minHeightPanel = screenSize.height * 0.45;
              maxHeightPanel = screenSize.height * 0.7;
              panelBuilder = const BookCar();
            } else if (next == 'find_driver') {
            } else if (next == 'wait_driver') {
            } else if (next == 'comming_driver') {
            } else if (next == 'moving') {
            } else if (next == 'complete') {}
          });
        });
        return Scaffold(
          body: Stack(
            children: [
              const MyMap(),
              ////////////////////////////////////////////////////// LOCATION BUTTON
              if (currentLocation)
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
              if (ref.read(stepProvider) == 'create_trip')
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.08,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(80, 220, 220, 220),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.solidCircleDot,
                                      size: 16,
                                      color: Color(0xff006FD5),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      ref
                                          .read(departureLocationProvider)
                                          .structuredFormatting!
                                          .mainText!,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(27, 8, 0, 8),
                                  child: Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: const Color.fromARGB(
                                        255, 225, 225, 225),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.solidCircleDot,
                                      size: 16,
                                      color: Color(0xffFA4848),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      ref
                                          .read(arrivalLocationProvider)
                                          .structuredFormatting!
                                          .mainText!,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 11, vertical: 6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0)),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 225, 225, 225))),
                            child: const Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.circlePlus,
                                  color: Color(0xffFA4848),
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Thêm',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: SlidingUpPanel(
                  backdropColor: Colors.black,
                  backdropOpacity: 0.5,
                  backdropEnabled: true,
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
                  panelBuilder: (sc) => panelBuilder,
                ),
              ),
              if (ref.read(stepProvider) == 'create_trip')
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 144,
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffEAEAEA), // Màu của border top
                          width: 1, // Độ dày của border top
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(80, 230, 230, 230),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(1, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatefulBuilder(
                              builder: (context, setPaymentMethodState) =>
                                  InkWell(
                                onTap: () {
                                  showPaymentMethod(setPaymentMethodState);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      paymentImage,
                                      width: 24,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      paymentMethod,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.angleDown,
                                      size: 18,
                                      color: Color.fromARGB(255, 93, 93, 93),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            StatefulBuilder(
                              builder: (context, setDiscountState) => InkWell(
                                onTap: () {
                                  showDiscountList(setDiscountState);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'lib/assets/images/discount_icon.png',
                                      width: 24,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 160),
                                      child: Text(
                                        discount.isEmpty ? 'Ưu đãi' : discount,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        BottomButton(
                          backButton: () {
                            ref.read(stepProvider.notifier).setStep('default');
                            ref
                                .read(departureLocationProvider.notifier)
                                .setDepartureLocation(LocationModel());
                            ref
                                .read(arrivalLocationProvider.notifier)
                                .setArrivalLocation(LocationModel());

                            Navigator.pop(context);
                          },
                          nextButton: () {},
                          nextButtonText: 'đặt xe',
                          opacity: true,
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
