import 'dart:convert';

import 'package:customer/providers/app_language.dart';
import 'package:customer/providers/auth_provider.dart';
import 'package:customer/providers/customerProvider.dart';
import 'package:customer/providers/stepProvider.dart';
import 'package:customer/screens/home_screen.dart';
import 'package:customer/screens/login_page/login_page.dart';
import 'package:customer/screens/splash_screen/index.dart';
import 'package:customer/utils/Google_Api_Key.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/customer_model.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  // void login(User value, WidgetRef ref) async {
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'http://$ip:4100/v1/customer-auth/login',
  //     data: json.encode({
  //       'name': value.displayName,
  //       'email': value.email,
  //       'phonenumber': value.phoneNumber,
  //     }),
  //     options: Options(
  //       method: 'POST',
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     dynamic parsed =
  //         json.decode(response.data!['info']).cast<String, dynamic>();
  //     ref
  //         .read(customerProvider.notifier)
  //         .setCustomer(CustomerModel.fromMap(parsed));
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authProvider);
    // final isAuth = authState.valueOrNull != null;
    // Widget currentPage = const SplashScreen();
    // if (ref.read(stepProvider) == 'splash_page' &&
    //     !authState.isLoading &&
    //     !authState.hasError) {
    //   if (isAuth) {
    //     login(authState.value!, ref);
    //   }
    //   currentPage = isAuth ? const HomeScreen() : const LoginPage();
    // } else if (ref.read(stepProvider) == 'login_page' &&
    //     !authState.isLoading &&
    //     !authState.hasError) {
    //   if (isAuth) {
    //     login(authState.value!, ref);
    //   }
    //
    //   currentPage = const HomeScreen();
    // }

    final currentLanguage = ref.watch(languageProvider);

    return MaterialApp(
      // Modified by Quang Thanh to handle localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(currentLanguage),

      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFE8248)),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color(0xffFFFFFF),
          foregroundColor: const Color(0xffF86C1D),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFE8248),
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            elevation: 0,
            backgroundColor: Colors.white,
            side: const BorderSide(
              width: 1,
              color: Color(0xfffe8248),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge:
                  GoogleFonts.montserrat(color: const Color(0xffF86C1D), fontWeight: FontWeight.w600, fontSize: 18),
              titleMedium:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w500, fontSize: 16),
              titleSmall:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w600, fontSize: 18),
              bodySmall:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w700, fontSize: 16),
              bodyMedium:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w500, fontSize: 14),
              bodyLarge:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w600, fontSize: 14),
              headlineMedium: GoogleFonts.montserrat(
                color: const Color(0xff6A6A6A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              headlineSmall: GoogleFonts.montserrat(
                color: const Color(0xffA0A0A0),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              displayMedium: GoogleFonts.montserrat(
                color: const Color(0xfffe8248),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              displaySmall: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 106, 106, 106),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              labelLarge: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
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
      ),
      home: const HomeScreen(),
    );
  }
}
