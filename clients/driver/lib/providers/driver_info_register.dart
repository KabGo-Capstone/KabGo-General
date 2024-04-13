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
  
  void setPhoneNumber(String phoneNumber) {
    state.phoneNumber = phoneNumber;
  }
  
  void setServiceName(String serviceName) {
    state.serviceName = serviceName;
  }
  
  void setAvatar(String avatar) {
    state.avatar = avatar;
  }
}

final driverInfoRegisterProvider =
    StateNotifierProvider<DriverInfoRegisterNotifier, DriverInfoRegisterModel>(
        (ref) => DriverInfoRegisterNotifier());
