import 'package:customer/screens/home/components/animated_text.dart';
import 'package:customer/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FindArrivalButton extends StatelessWidget {
  const FindArrivalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const Search(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0, 1);
                  const end = Offset(0, 0);

                  final tween = Tween(begin: begin, end: end);
                  return SlideTransition(
                    position: tween.animate(animation),
                    child: child,
                  );
                },
              ));
        },
        child: Container(
          height: 56,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 73, 73, 73).withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.solidCircleDot,
                  size: 16,
                  color: Color(0xffFA4848),
                ),
              ),
              const SizedBox(
                width: 13,
              ),
              const AnimatedText()
            ],
          ),
        ),
      ),
    );
  }
}
