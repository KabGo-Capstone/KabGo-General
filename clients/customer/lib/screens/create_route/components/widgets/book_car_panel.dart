import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/mapProvider.dart';
import 'package:customer/providers/routeProvider.dart';
import 'package:customer/providers/socketProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/create_route/components/book_car/choose_payment_method.dart';
import 'package:customer/screens/create_route/components/book_car/discount_page.dart';
import 'package:customer/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookCarPanel extends ConsumerStatefulWidget {
  const BookCarPanel({
    super.key,
    required this.bottomController,
  });

  final PanelController bottomController;

  @override
  _BookCarPanelState createState() => _BookCarPanelState();
}

class _BookCarPanelState extends ConsumerState<BookCarPanel> {
  String paymentMethod = 'Tiền mặt';
  String paymentImage = 'lib/assets/images/cash_icon.png';
  String discount = '';

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

  Future<void> bookCar() async {
    SocketClient socketClient = ref.read(socketClientProvider.notifier);
    socketClient.emitBookingCar(ref.read(departureLocationProvider),
        ref.read(arrivalLocationProvider), ref.read(routeProvider));
    // socketClient.emitBookingCar(ref.read(departureLocationProvider).postion!);
    // LocationModel departure = ref.read(departureLocationProvider);
    // LocationModel arrival = ref.read(arrivalLocationProvider);
    // RouteModel routeModel = ref.read(routeProvider);
    // CustomerModel customerModel = ref.read(customerProvider);
    // socketClient.emitBookingCar(departure, arrival, routeModel, customerModel);
    // ref.read(couponProvider.notifier).setCoupon(0);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlidingUpPanel(
        minHeight: 0,
        maxHeight: 144,
        controller: widget.bottomController,
        defaultPanelState: PanelState.OPEN,
        isDraggable: false,
        panelBuilder: (sc) => Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xffEAEAEA),
                width: 1,
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
                    builder: (context, setPaymentMethodState) => InkWell(
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
                            style: Theme.of(context).textTheme.bodyLarge,
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
                            constraints: const BoxConstraints(maxWidth: 160),
                            child: Text(
                              discount.isEmpty ? 'Ưu đãi' : discount,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
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
                nextButton: () {
                  bookCar();
                },
                nextButtonText: 'đặt xe',
                opacity: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
