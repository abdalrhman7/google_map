import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyPlaces {
  final String name;
  final String id;
  final LatLng position;

  NearbyPlaces({required this.name, required this.id, required this.position});

  factory NearbyPlaces.fromJson(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final name = json['tags']['name'] ?? 'Unknown';
    final lat = json['lat']?.toDouble() ?? 0.0;
    final lng = json['lng']?.toDouble() ?? 0.0;
    final position = LatLng(lat, lng);
    return NearbyPlaces(name: name, id: id, position: position);
  }
}
