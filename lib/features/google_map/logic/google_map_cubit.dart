import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/utlis/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

part 'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapInitial());

  LocationService locationService = LocationService();
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Marker? searchedLocationMarker;

  TextEditingController googleMapAutoCompleteController =
      TextEditingController();

  Future<void> updateCurrentLocation() async {
    try {
      LocationData locationData = await locationService.getLocationData();
      markers.add(Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(locationData.latitude!, locationData.longitude!),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ));
      LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);
      animateCameraPosition(latLng);
      emit(UpdateCurrentLocation());
    } on LocationServiceException catch (e) {
      emit(LocationServiceExceptionError('Location services are required to use this feature. Please enable location services'));
    } on LocationPermissionException catch (e) {
      emit(LocationPermissionExceptionError('Location permission is required to use this feature. Please grant location permission.'));
    }
  }

  Future<void> goToSearchedLocation(LatLng latLng) async {
    markers.remove(searchedLocationMarker);
    searchedLocationMarker = Marker(
      markerId: const MarkerId('searched_location'),
      position: latLng,
    );
    markers.add(searchedLocationMarker!);
    animateCameraPosition(latLng);
    emit(UpdateCurrentLocation());
  }

  void animateCameraPosition(LatLng latLng) {
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(
        latLng,
        15,
      ),
    );
  }
}
