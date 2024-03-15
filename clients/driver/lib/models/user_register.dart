import 'package:json_annotation/json_annotation.dart';

part 'user_register.g.dart';

@JsonSerializable()
class UserRegister {
  String firstName;
  String lastName;
  String phoneNumber;
  String city;
  String referrerCode;
  String email;

  UserRegister(this.firstName, this.lastName, this.phoneNumber, this.city, this.referrerCode, this.email);

  factory UserRegister.fromJson(Map<String, dynamic> json) => _$UserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterToJson(this);
}
