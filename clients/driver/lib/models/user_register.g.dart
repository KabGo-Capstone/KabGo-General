// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegister _$UserRegisterFromJson(Map<String, dynamic> json) => UserRegister(
      json['firstname'] as String,
      json['lastname'] as String,
      json['phonenumber'] as String,
      json['city'] as String,
      json['referrer'] as String,
    );

Map<String, dynamic> _$UserRegisterToJson(UserRegister instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phonenumber': instance.phonenumber,
      'city': instance.city,
      'referrer': instance.referrer,
    };
