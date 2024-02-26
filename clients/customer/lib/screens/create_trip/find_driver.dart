import 'package:customer/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FindDriver extends StatefulWidget {
  const FindDriver({Key? key}) : super(key: key);

  @override
  State<FindDriver> createState() => _FindDriverState();
}

class _FindDriverState extends State<FindDriver> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      showBottomModalLoading();
    });
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
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xfffe8248),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(top: 16),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(
                'Tạo chuyến',
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              const Spacer(),
              // InkWell(
              //   onTap: () {
              //     ref.read(stepProvider.notifier).setStep('home');
              //     ref.read(mapProvider.notifier).setMapAction('SET_DEFAULT');
              //   },
              //   child: const FaIcon(
              //     FontAwesomeIcons.xmark,
              //     size: 32,
              //     color: Colors.white,
              //   ),
              // ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '1',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Image.asset(
                'lib/assets/step_line.png',
                width: 90,
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '2',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Image.asset(
                'lib/assets/step_line.png',
                width: 90,
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '3',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Text(
              'Đang tìm xe...',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
