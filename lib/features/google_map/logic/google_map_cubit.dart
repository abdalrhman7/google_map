import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
  bool isSearched = false;
  LatLng currentLocation = const LatLng(0, 0);
  LatLng searchedLocation = const LatLng(0, 0);
  Set<Polyline> polyLines = {};

  PolylinePoints polylinePoints = PolylinePoints();

  void drawRoute()async {
    await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: dotenv.env['google_api_key']!,
      request: PolylineRequest(
        origin: PointLatLng(currentLocation.latitude, currentLocation.longitude),
        destination: PointLatLng(searchedLocation.latitude, searchedLocation.longitude),
        mode: TravelMode.driving,

      ),

    ).then((value) {
      polyLines.add(Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blue,
        points: value.points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
      ));
    });
    polylinePoints.decodePolyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@");
    isSearched = false;
    emit(UpdateCurrentLocation());
  }


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
      currentLocation = latLng;
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
    polyLines.clear();
    searchedLocationMarker = Marker(
      markerId: const MarkerId('searched_location'),
      position: latLng,
    );
    markers.add(searchedLocationMarker!);
    searchedLocation = latLng;
    animateCameraPosition(latLng);
    isSearched = true;
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
