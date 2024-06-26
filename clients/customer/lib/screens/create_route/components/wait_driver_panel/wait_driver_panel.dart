import 'package:customer/functions/convertTimeFormat.dart';
import 'package:customer/models/driver_accept_model.dart';
import 'package:customer/models/driver_model.dart';
import 'package:customer/models/location_model.dart';
import 'package:customer/models/route_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/driverAcceptProvider.dart';
import 'package:customer/providers/driverProvider.dart';
import 'package:customer/providers/routeProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/create_route/components/wait_driver_panel/notification_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitDriverPanel extends ConsumerStatefulWidget {
  const WaitDriverPanel({Key? key}) : super(key: key);

  @override
  _WaitDriverPanelState createState() => _WaitDriverPanelState();
}

class _WaitDriverPanelState extends ConsumerState<WaitDriverPanel> {
  bool cancelButton = true;
  Widget widgetText = Text(
    'Tài xế của bạn đang đến...',
    style: GoogleFonts.montserrat(
        color: const Color(0xff6A6A6A),
        fontWeight: FontWeight.w600,
        fontSize: 18),
    textAlign: TextAlign.start,
  );

  void showDriverNotification(DriverAcceptedModel driverModel) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) => NotificationBottomSheet(
              driverModel: driverModel,
            ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RouteModel routeModel = ref.read(routeProvider);
    LocationModel departure = ref.read(departureLocationProvider);
    LocationModel arrival = ref.read(arrivalLocationProvider);

    print(departure.structuredFormatting!.mainText);
    print(arrival.structuredFormatting!.mainText);
    DriverAcceptedModel driverModel = ref.read(driverAcceptProvider);
    print('===========> WAIT_DRIVER_PANEL BUILD');

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(80, 190, 190, 190),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(1, 0),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ///////////////////////////////////////////////////// LOCATION INPUT
            Align(
              alignment: Alignment.topLeft,
              child: Consumer(
                builder: (context, ref, child) {
                  ref.listen(stepProvider, ((previous, next) {
                    setState(() {
                      if (next == 'wait_driver') {
                        widgetText = Text(
                          'Tài xế của bạn đang đến...',
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.start,
                        );
                      } else if (next == 'comming_driver') {
                        cancelButton = false;
                        showDriverNotification(driverModel);
                        widgetText = Text(
                          'Tài xế của bạn đã đến',
                          style: GoogleFonts.montserrat(
                              color: const Color(0xff29BD11),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                          textAlign: TextAlign.start,
                        );
                      } else if (next == 'moving') {
                        widgetText = Text(
                          'Tài xế của bạn',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.start,
                        );
                      } else {}
                    });
                  }));
                  return Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      widgetText
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Container(
                  width: 64,
                  height: 64,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Image.network(driverModel.driver!.avatar),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  height: 64,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text(
                          '${driverModel.driver!.lastName} ${driverModel.driver!.firstName}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            height: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 170,
                        child: Text(
                          'Honda Wave RSX',
                          style: TextStyle(
                            color: Color(0xff6A6A6A),
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '4.8',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        ...List.generate(
                            5,
                            (index) => const Padding(
                                  padding: EdgeInsets.only(bottom: 3, left: 2),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    color: Color.fromARGB(255, 245, 221, 4),
                                    size: 14,
                                  ),
                                ))
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF4EF),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffFFB393),
                        ),
                      ),
                      child: Text(
                        '68S164889',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xffEAEAEA), // Màu của border top
                    width: 1, // Độ dày của border top
                  ),
                  bottom: BorderSide(
                    color: Color(0xffEAEAEA), // Màu của border top
                    width: 1, // Độ dày của border top
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidMap,
                        color: Color(0xffFE8248),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        routeModel.distance!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidClock,
                        color: Color(0xffFE8248),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        convertTimeFormat(routeModel.time!),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Text(
                    routeModel.price,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Lộ trình của bạn',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.solidCircleDot,
                          size: 21,
                          color: Color(0xff006FD5),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF9F9F9),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffF2F2F2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(departure.structuredFormatting!.mainText!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '${departure.structuredFormatting!.mainText!}, ${(departure.structuredFormatting!.secondaryText!)}',
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.solidCircleDot,
                          size: 21,
                          color: Color(0xffFA4848),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF9F9F9),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffF2F2F2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                arrival.structuredFormatting!.mainText!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${arrival.structuredFormatting!.mainText!}, ${(arrival.structuredFormatting!.secondaryText!)}',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (cancelButton)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // SocketClient socketClient =
                    //     ref.read(socketClientProvider.notifier);
                    // LocationModel departure =
                    //     ref.read(departureLocationProvider);
                    // LocationModel arrival = ref.read(arrivalLocationProvider);
                    // RouteModel routeModel = ref.read(routeProvider);
                    // CustomerModel customerModel = ref.read(customerProvider);
                    // socketClient.emitCancelBooing(
                    //     departure, arrival, routeModel, customerModel);
                    // ref.read(stepProvider.notifier).setStep('home');
                    // ref.read(mapProvider.notifier).setMapAction('SET_DEFAULT');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 251, 60, 46)),
                  child: Text('hủy chuyến'.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
