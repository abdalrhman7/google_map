part of 'google_map_cubit.dart';

@immutable
sealed class GoogleMapState {}

final class GoogleMapInitial extends GoogleMapState {}

final class UpdateCurrentLocation extends GoogleMapState {}
