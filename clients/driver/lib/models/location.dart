class LocationPostion {
  final double lat;
  final double lng;
  final double? bearing;

  LocationPostion({required this.lat, required this.lng, this.bearing = 0});

  bool hasValue() {
    return lat != 0 && lng != 0;
  }

  factory LocationPostion.fromJson(Map<String, dynamic> json) {
    return LocationPostion(
      lat: json['lat'],
      lng: json['lng'],
      bearing: json['bearing'],
    );
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
        'bearing': bearing,
      };
}
