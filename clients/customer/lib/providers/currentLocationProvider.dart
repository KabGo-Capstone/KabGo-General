import 'package:customer/models/location_model.dart';
import 'package:riverpod/riverpod.dart';

class CurrentLocationNotifier extends StateNotifier<LocationModel> {
  CurrentLocationNotifier() : super(LocationModel());

  void setCurrentLocation(LocationModel value) async {
    state = value;
  }
}

final currentLocationProvider =
    StateNotifierProvider<CurrentLocationNotifier, LocationModel>(
        (ref) => CurrentLocationNotifier());
