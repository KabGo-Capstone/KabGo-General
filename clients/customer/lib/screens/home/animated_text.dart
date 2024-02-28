import 'package:flutter/material.dart';

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
    return Text(
      'Bạn đang muốn đi đâu?',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
