import 'package:driver/models/emergency_contact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyContactNotifier extends StateNotifier<EmergencyContactModel> {
  EmergencyContactNotifier() : super(EmergencyContactModel());

  void setEmergencyContactModel(EmergencyContactModel value) {
    state = value;
  }

  void setNameContact(String name) {
    state.nameContact = name;
  }

  void setPhoneContact(String phone) {
    state.phoneContact = phone;
  }

  void setRelationship(String relationship) {
    state.relationship = relationship;
  }

  void setAddressContact(String address) {
    state.addressContact = address;
  }
}

final emergencyContactProvider =
    StateNotifierProvider<EmergencyContactNotifier, EmergencyContactModel>(
        (ref) => EmergencyContactNotifier());
