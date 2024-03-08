import 'package:json_annotation/json_annotation.dart';

part 'user_register.g.dart';

@JsonSerializable()
class UserRegister {
  String firstname;
  String lastname;
  String phonenumber;
  String city;
  String referrer;

  UserRegister(this.firstname, this.lastname, this.phonenumber, this.city, this.referrer);

  factory UserRegister.fromJson(Map<String, dynamic> json) => _$UserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterToJson(this);
}
