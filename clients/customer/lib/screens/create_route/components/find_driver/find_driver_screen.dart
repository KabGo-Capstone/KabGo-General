import 'package:customer/models/location_model.dart';
import 'package:customer/providers/arrivalLocationProvider.dart';
import 'package:customer/providers/departureLocationProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FindDriver extends ConsumerStatefulWidget {
  const FindDriver({Key? key}) : super(key: key);

  @override
  ConsumerState<FindDriver> createState() => _FindDriverState();
}

class _FindDriverState extends ConsumerState<FindDriver> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 10), () {
    //   showBottomModalLoading();
    // });
    // Future.delayed(const Duration(seconds: 5), () {
    //   ref.read(stepProvider.notifier).setStep('wait_driver');
    // });
  }

  void showBottomModalLoading() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) => const LoadingDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    LocationModel departure = ref.read(departureLocationProvider);
    LocationModel arrival = ref.read(arrivalLocationProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
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
                  height: 12,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Đang tìm tài xế...',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                                style:
                                    Theme.of(context).textTheme.displayMedium),
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
                              style: Theme.of(context).textTheme.displayMedium,
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
        ],
      ),
    );
  }
}
