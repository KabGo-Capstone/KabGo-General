class LocationAddress {
  final String description;
  final String lng;
  final String lat;

  LocationAddress({
    required this.description,
    required this.lng,
    required this.lat,
  });

  bool hasValue() {
    return description != "" && lng != "" && lat != "";
  }

  factory LocationAddress.fromJson(Map<String, dynamic> json) {
    return LocationAddress(
      description: json['description'],
      lng: json['lng'],
      lat: json['lat'],
    );
  }

  Map<String, dynamic> toJson() => {
        'description': description,
        'lng': lng,
        'lat': lat,
      };
}
