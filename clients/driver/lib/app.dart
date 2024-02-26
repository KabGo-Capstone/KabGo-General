import 'package:driver/configs/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:driver/configs/router.dart';

class KabGoDriverApplication extends StatelessWidget {
  const KabGoDriverApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KabGo Driver',
      theme: AppThemes.light(),
      darkTheme: AppThemes.dark(),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}