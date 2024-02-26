import 'package:customer/screens/menu_screen/menu_screen.dart';
import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  const OptionsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(120, 176, 176, 176),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ]),
      child: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const MenuScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1, 0.0);
                  const end = Offset.zero;

                  final tween = Tween(begin: begin, end: end);

                  return SlideTransition(
                    position: tween.animate(animation),
                    child: child,
                  );
                },
              ));
        },
        padding: EdgeInsets.zero,
        icon: Image.asset('lib/assets/options_button.png'),
        iconSize: 50,
      ),
    );
  }
}
