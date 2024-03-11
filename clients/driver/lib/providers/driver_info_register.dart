import 'package:driver/models/driver_info_register.dart';
import 'package:riverpod/riverpod.dart';

class DriverInfoRegisterNotifier
    extends StateNotifier<DriverInfoRegisterModel> {
  DriverInfoRegisterNotifier() : super(DriverInfoRegisterModel());

  void setDriverModel(DriverInfoRegisterModel value) async {
    state = value;
  }

  void setFirstName(String fName) {
    state.firstName = fName;
  }

  void setLastName(String lName) {
    state.lastName = lName;
  }

  void setIdDriver(String idDriver) {
    state.id = idDriver;
  }

  void setEmailDriver(String email) {
    state.email = email;
  }
}

final driverInfoRegisterProvider =
    StateNotifierProvider<DriverInfoRegisterNotifier, DriverInfoRegisterModel>(
        (ref) => DriverInfoRegisterNotifier());
