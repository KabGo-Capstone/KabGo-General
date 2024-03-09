import 'package:driver/configs/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:driver/configs/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KabGoDriverApplication extends ConsumerWidget {
  const KabGoDriverApplication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        return MaterialApp.router(
      title: 'KabGo Driver',
      theme: AppThemes.light(),
      darkTheme: AppThemes.dark(),
      themeMode: ThemeMode.light,
      routerConfig: ref.watch(router),
    );
  }
}