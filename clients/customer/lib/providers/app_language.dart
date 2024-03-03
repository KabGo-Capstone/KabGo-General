import 'package:riverpod/riverpod.dart';

class AppLanguage extends StateNotifier<String> {
  AppLanguage() : super('vi');
  //
  void setLanguage(String value) async {
    state = value;
  }
}

final languageProvider = StateNotifierProvider<AppLanguage, String>((ref) => AppLanguage());
