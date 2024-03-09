import 'package:driver/configs/themes/app.color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static light({Color primaryColor = AppColors.primary}) {
    return ThemeData(
      fontFamilyFallback: const <String>[
        'Montserrat',
        'Roboto',
        'Arial',
        'sans-serif'
      ],
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: AppColors.gray,
      cardColor: AppColors.white,
      dividerColor: AppColors.white.withOpacity(1),
      shadowColor: AppColors.grayDark,
      primarySwatch: AppColors.getMaterialColorFromColor(primaryColor),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
            color: primaryColor, fontWeight: FontWeight.w600, fontSize: 18),
        titleMedium: GoogleFonts.montserrat(
          color: const Color.fromARGB(255, 50, 50, 50),
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        titleSmall: GoogleFonts.montserrat(
          color: const Color(0xff6A6A6A),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),

        bodySmall: GoogleFonts.montserrat(
          color: AppColors.black,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.montserrat(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        bodyLarge: GoogleFonts.montserrat(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        headlineMedium: GoogleFonts.montserrat(
          color: const Color.fromARGB(255, 70, 70, 70),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.montserrat(
          color: const Color.fromARGB(255, 140, 140, 140),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        displaySmall: GoogleFonts.montserrat(
          color: const Color.fromARGB(255, 106, 106, 106),
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        labelLarge: GoogleFonts.montserrat(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        labelMedium: GoogleFonts.montserrat(
          color: const Color(0xffFFFFFF),
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ), //button
        labelSmall: GoogleFonts.montserrat(
          color: const Color(0xffA6A6A6),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ), //place holder
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.black,
        selectionColor: AppColors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 219, 219, 219),
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
      ),
      useMaterial3: true,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }

  static dark({Color primaryColor = AppColors.primary}) {
    return ThemeData(
      fontFamilyFallback: const <String>[
        'Montserrat',
        'Roboto',
        'Arial',
        'sans-serif'
      ],
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: AppColors.black,
      cardColor: AppColors.blackLight,
      dividerColor: AppColors.white.withOpacity(0.2),
      shadowColor: AppColors.text,
      primarySwatch: AppColors.getMaterialColorFromColor(primaryColor),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      colorScheme: const ColorScheme.dark(),
      useMaterial3: true,
    );
  }
}
