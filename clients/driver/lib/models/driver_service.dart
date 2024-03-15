
import 'package:json_annotation/json_annotation.dart';

part 'driver_service.g.dart';

@JsonSerializable()
class Service {
  final String id;
  final String name;

  Service(this.id, this.name);
  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
