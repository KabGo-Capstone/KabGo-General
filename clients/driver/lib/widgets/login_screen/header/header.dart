import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KabGo Driver - Partner',
          style: GoogleFonts.montserratAlternates(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              text: 'Drive and ',
              children: [
                TextSpan(
                  text: 'earn',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: ' with KabGo.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
