import 'package:latlong2/latlong.dart';

class LocationPoint {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  LocationPoint({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    return LocationPoint(
      id: json['id'].toString(),
      name: json['name'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
  };

  LatLng toLatLng() => LatLng(latitude, longitude);
}
