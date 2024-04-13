class Vehicle {
  String name;
  String identity_number;
  String color;
  String brand;

  Vehicle({
    required this.name,
    required this.identity_number,
    required this.brand,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'identity_number': identity_number,
      'color': color,
      'brand': brand,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      name: map['name'] as String,
      identity_number: map['identity_number'] as String,
      color: map['color'] as String,
      brand: map['brand'] as String,
    );
  }
}
