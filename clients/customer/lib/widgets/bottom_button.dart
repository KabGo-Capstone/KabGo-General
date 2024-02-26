import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomButton extends StatelessWidget {
  const BottomButton(
      {Key? key,
      required this.backButton,
      required this.nextButton,
      required this.nextButtonText, required this.opacity})
      : super(key: key);

  final void Function() backButton;
  final void Function() nextButton;
  final String nextButtonText;
  final bool opacity;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 54,
          height: 54,
          child: OutlinedButton(
            onPressed: backButton,
            child: const FaIcon(
              FontAwesomeIcons.arrowLeft,
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
            child: Opacity(
              opacity: opacity ? 1 :0.4,
              child: ElevatedButton(
                onPressed: opacity? nextButton:(){},
                child: Text(nextButtonText.toUpperCase(),
                    style: Theme.of(context).textTheme.labelMedium),
              ),
            ),
          ),
        )
      ],
    );
  }
}
