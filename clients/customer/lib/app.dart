import 'package:customer/providers/app_language.dart';
import 'package:customer/screens/create_route/create_route.dart';
import 'package:customer/screens/home/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

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
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFE8248)),
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
              titleMedium: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 50, 50, 50), fontWeight: FontWeight.w700, fontSize: 16),
              titleSmall:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w600, fontSize: 18),

              bodySmall:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w700, fontSize: 16),
              bodyMedium:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w500, fontSize: 14),
              bodyLarge:
                  GoogleFonts.montserrat(color: const Color(0xff6A6A6A), fontWeight: FontWeight.w600, fontSize: 14),
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
      home: const Home(),
      // home: const Search(),
      // home: const CreateRoute(),
    );
  }
}
