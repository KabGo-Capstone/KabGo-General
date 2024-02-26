import 'package:driver/configs/themes/app.color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      dividerColor: AppColors.black.withOpacity(0.1),
      shadowColor: AppColors.grayDark,
      primarySwatch: AppColors.getMaterialColorFromColor(primaryColor),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      useMaterial3: true,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
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
