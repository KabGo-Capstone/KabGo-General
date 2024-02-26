import 'package:riverpod/riverpod.dart';

class MapNotifier extends StateNotifier<String> {
  MapNotifier() : super('FIND_DRIVER');

  void setMapAction(String value) async {
    state = value;
  }
}

final mapProvider =
    StateNotifierProvider<MapNotifier, String>((ref) => MapNotifier());
