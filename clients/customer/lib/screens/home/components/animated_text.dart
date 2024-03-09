import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({Key? key}) : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  int _currentIndex = 0;
  int _currentCharIndex = 0;
  int delayTime = 100;

  final List<String> _strings = [
    'Bạn đang muốn đi đâu? ',
    'Hãy để chúng tôi giúp bạn '
  ];

  void TypeWrittingAnimation() {
    delayTime = 100;
    if (_currentCharIndex < _strings[_currentIndex].length) {
      _currentCharIndex++;
      if (_currentCharIndex == _strings[_currentIndex].length) {
        delayTime = 2000;
      }
    } else {
      _currentIndex = (_currentIndex + 1) % _strings.length;
      _currentCharIndex = 0;
    }
    setState(() {});
    Future.delayed(Duration(milliseconds: delayTime), () {
      TypeWrittingAnimation();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TypeWrittingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_strings[_currentIndex].substring(0, _currentCharIndex),
        style: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 80, 80, 80),
            fontWeight: FontWeight.w600,
            fontSize: 16));
  }
}
