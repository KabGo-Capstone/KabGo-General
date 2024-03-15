// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegister _$UserRegisterFromJson(Map<String, dynamic> json) => UserRegister(
      json['firstName'] as String,
      json['lastName'] as String,
      json['phoneNumber'] as String,
      json['city'] as String,
      json['referrerCode'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$UserRegisterToJson(UserRegister instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'city': instance.city,
      'referrerCode': instance.referrerCode,
      'email': instance.email,
    };
