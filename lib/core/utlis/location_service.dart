import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location
        .serviceEnabled(); // Checks if the location service is enabled
    if (!isServiceEnabled) {
      isServiceEnabled = await location
          .requestService(); // Requests to enable the service if not enabled
      if (!isServiceEnabled) {
        throw LocationServiceException(); // Throws an exception if the service is not enabled after the request
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    var permissionStatus =
        await location.hasPermission(); // Checks the current permission status
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException(); // Throws an exception if permission is permanently denied
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location
          .requestPermission(); // Requests permission if it is denied
      if (permissionStatus != PermissionStatus.granted) {
        throw LocationPermissionException(); // Throws an exception if permission is not granted after the request
      }
    }
  }

  Future<LocationData> getLocationData() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
