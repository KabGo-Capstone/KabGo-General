class Service {
  final String id;
  final String name;
  final String description;
  final int basePrice;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      basePrice: json['basePrice'] as int,
    );
  }
}
