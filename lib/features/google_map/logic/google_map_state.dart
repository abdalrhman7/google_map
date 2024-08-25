part of 'google_map_cubit.dart';

@immutable
sealed class GoogleMapState {}

final class GoogleMapInitial extends GoogleMapState {}

final class UpdateCurrentLocation extends GoogleMapState {}

final class UpdateSearchedLocation extends GoogleMapState {}

final class LocationServiceExceptionError extends GoogleMapState {

  final String errorMessage;
  LocationServiceExceptionError(this.errorMessage);
}

final class LocationPermissionExceptionError extends GoogleMapState {
  final String errorMessage;
  LocationPermissionExceptionError(this.errorMessage);
}

final class ClearPolyLines extends GoogleMapState {}

final class DrawLine extends GoogleMapState {}

final class WeatherLoading extends GoogleMapState {}

final class WeatherLoaded extends GoogleMapState {
  final WeatherModel weatherModel;
  WeatherLoaded(this.weatherModel);
}

final class WeatherError extends GoogleMapState {
  final String errorMessage;
  WeatherError(this.errorMessage);
}
