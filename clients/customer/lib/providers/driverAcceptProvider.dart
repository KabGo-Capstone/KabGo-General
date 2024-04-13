import 'package:customer/models/driver_accept_model.dart';
import 'package:riverpod/riverpod.dart';

class DriverAcceptNotifier extends StateNotifier<DriverAcceptedModel> {
  DriverAcceptNotifier() : super(DriverAcceptedModel());

  void setDriver(DriverAcceptedModel value) async {
    state = value;
  }
}

final driverAcceptProvider = StateNotifierProvider<DriverAcceptNotifier, DriverAcceptedModel>(
    (ref) => DriverAcceptNotifier());
