import 'package:riverpod/riverpod.dart';

class MapNotifier extends StateNotifier<String> {
  MapNotifier() : super('default');

  void setMapAction(String value) async {
    state = value;
  }
}

final mapProvider =
    StateNotifierProvider<MapNotifier, String>((ref) => MapNotifier());
