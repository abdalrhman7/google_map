import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressModel {
  final String streetName;
  final String cityName;
  final String countryName;
  //final LatLng latLng;

  AddressModel({
    required this.streetName,
    required this.cityName,
    required this.countryName,
   // required this.latLng,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      streetName: json['streetName'],
      cityName: json['cityName'],
      countryName: json['countryName'],
      //latLng: json['latLng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'streetName': streetName,
      'cityName': cityName,
      'countryName': countryName,
      //'latLng': latLng,
    };
  }
}
