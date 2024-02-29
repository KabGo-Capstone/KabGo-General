import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteLocationItem extends StatelessWidget {
  const FavoriteLocationItem({super.key, required this.data});
  final Map<String, Object> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      margin: const EdgeInsets.only(right: 24),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 56,
            width: 56,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 245, 239),
              shape: BoxShape.circle,
            ),
            child: data['icon'] as Widget,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            data['title'].toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: const Color.fromARGB(255, 106, 106, 106),
            ),
          ),
        ],
      ),
    );
  }
}
