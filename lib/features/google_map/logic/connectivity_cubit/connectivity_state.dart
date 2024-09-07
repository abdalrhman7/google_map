part of 'connectivity_cubit.dart';

@immutable
sealed class ConnectivityState {}

final class ConnectivityInitial extends ConnectivityState {}


final class NoInternetConnection extends ConnectivityState {}

final class HasInternetConnection extends ConnectivityState {}
