import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps/core/utlis/location_service.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapInitial());

  final LocationService locationService = LocationService();
  final TextEditingController searchController = TextEditingController();

  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Marker? searchedLocationMarker;

  LatLng currentLocation = const LatLng(0, 0);
  LatLng searchedLocation = const LatLng(0, 0);

  Set<Polyline> polyLines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  double? distanceInKm;
  int? durationInMinutes;

  bool isSearched = false;
  bool isLineDrawn = false;

  Future<void> updateCurrentLocation() async {
    try {
      final locationData = await locationService.getLocationData();
      currentLocation = LatLng(locationData.latitude!, locationData.longitude!);

      markers.add(
        Marker(
          markerId: const MarkerId(StringConstants.userLocation),
          position: currentLocation,
          infoWindow: const InfoWindow(title: StringConstants.yourLocation),
        ),
      );

      animateCameraPosition(currentLocation);
      emit(UpdateCurrentLocation());
    } on LocationServiceException {
      emit(LocationServiceExceptionError(StringConstants.enableLocationErrorMessage));
    } on LocationPermissionException {
      emit(LocationPermissionExceptionError(StringConstants.locationPermissionErrorMessage));
    }
  }

  Future<void> goToSearchedLocation(LatLng latLng) async {
    markers.remove(searchedLocationMarker);
    polyLines.clear();

    searchedLocation = latLng;
    searchedLocationMarker = Marker(
      markerId: const MarkerId(StringConstants.searchedLocation),
      position: searchedLocation,
    );
    markers.add(searchedLocationMarker!);

    animateCameraPosition(searchedLocation);
    isSearched = true;
    emit(UpdateSearchedLocation());
  }

  void drawLineAndMoveCamera() async {
    var result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: dotenv.env[StringConstants.googleApiKey]!,
      request: PolylineRequest(
        origin: PointLatLng(currentLocation.latitude, currentLocation.longitude),
        destination: PointLatLng(searchedLocation.latitude, searchedLocation.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      polyLines.add(Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blue,
        points: result.points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
      ));
      _moveCameraToFitPolyline(result.points);
    }
    distanceInKm = result.totalDistanceValue! / 1000.0;
    durationInMinutes = result.totalDurationValue! ~/ 60;
    isSearched = false;
    isLineDrawn = true;
    emit(DrawLine());
  }

  void _moveCameraToFitPolyline(List<PointLatLng> points) {
    List<LatLng> latLngPoints = points.map((point) => LatLng(point.latitude, point.longitude)).toList();

    LatLngBounds bounds;
    if (latLngPoints.length == 1) {
      bounds = LatLngBounds(southwest: latLngPoints.first, northeast: latLngPoints.first);
    } else {
      LatLng southwest = latLngPoints.reduce((a, b) => LatLng(
        a.latitude < b.latitude ? a.latitude : b.latitude,
        a.longitude < b.longitude ? a.longitude : b.longitude,
      ));

      LatLng northeast = latLngPoints.reduce((a, b) => LatLng(
        a.latitude > b.latitude ? a.latitude : b.latitude,
        a.longitude > b.longitude ? a.longitude : b.longitude,
      ));

      bounds = LatLngBounds(southwest: southwest, northeast: northeast);
    }
    mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 40));
  }


  void clearPolyLinesAndMarkers() {
    markers.remove(searchedLocationMarker);
    polyLines.clear();
    isLineDrawn = false;
    emit(ClearPolyLines());
  }

  void animateCameraPosition(LatLng latLng) {
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(latLng, 15),
    );
  }
}
