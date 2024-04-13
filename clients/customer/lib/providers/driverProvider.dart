import 'package:riverpod/riverpod.dart';

import '../models/driver_model.dart';

class DriverNotifier extends StateNotifier<DriverModel> {
  DriverNotifier() : super(DriverModel());

  void setDriver(DriverModel value) async {
    state = value;
  }
}

final driverProvider = StateNotifierProvider<DriverNotifier, DriverModel>(
    (ref) => DriverNotifier());
