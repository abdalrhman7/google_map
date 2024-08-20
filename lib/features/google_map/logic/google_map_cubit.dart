import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/utlis/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:location/location.dart';

part 'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapInitial());

  LocationService locationService = LocationService();
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Marker? searchedLocationMarker ;

  TextEditingController googleMapAutoCompleteController = TextEditingController();

  Future<void> updateCurrentLocation(
      ) async {
    LocationData locationData = await locationService.getLocationData();
    markers.add(Marker(
      markerId: const MarkerId('user_location'),
      position: LatLng(locationData.latitude!, locationData.longitude!),
      infoWindow: const InfoWindow(title: 'Your Location'),
    ));
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(locationData.latitude!, locationData.longitude!), 15),
    );
    emit(UpdateCurrentLocation());
  }

  Future<void> goToSearchedLocation(
      Prediction prediction) async {
    googleMapAutoCompleteController.clear();
    markers.remove(searchedLocationMarker);
    searchedLocationMarker = Marker(
      markerId: MarkerId(prediction.description!),
      position: LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!)),
      infoWindow: InfoWindow(title: prediction.description),
    );
    markers.add(searchedLocationMarker!);
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!)), 15),
    );
    emit(UpdateCurrentLocation());
  }


}
