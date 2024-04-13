import 'dart:convert';

class DriverInfoRegisterModel {
  String? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? referralCode;
  String? city;
  String? email;
  String? serviceName;
  String? avatar;

  DriverInfoRegisterModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.referralCode,
    this.city,
    this.email,
    this.serviceName,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'referralCode': referralCode,
      'city': city,
      'email': email,
      'avatar': avatar,
      'serviceName': serviceName,
    };
  }

  factory DriverInfoRegisterModel.fromMap(Map<String, dynamic> map) {
    return DriverInfoRegisterModel(
      id: map['id'] != null ? map['id'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      referralCode:
          map['referralCode'] != null ? map['referralCode'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      serviceName: map['serviceName'] != null ? map['serviceName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverInfoRegisterModel.fromJson(String source) =>
      DriverInfoRegisterModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
