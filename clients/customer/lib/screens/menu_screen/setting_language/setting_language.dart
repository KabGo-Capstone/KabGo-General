import 'package:customer/constants/key_translate.dart';
import 'package:customer/providers/app_language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingLanguage extends ConsumerWidget {
  const SettingLanguage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(languageKey.tr()), // Đảm bảo rằng bạn đã định nghĩa chuỗi này trong tệp JSON
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(languageProvider.notifier).setLanguage('vi');
                context.setLocale(const Locale('vi')); // Cập nhật EasyLocalization
              },
              child: Text(vietnamesKey.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(languageProvider.notifier).setLanguage('en');
                context.setLocale(const Locale('en')); // Cập nhật EasyLocalization
              },
              child: Text(usKey.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
