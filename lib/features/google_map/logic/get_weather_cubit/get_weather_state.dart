part of 'get_weather_cubit.dart';

@immutable
sealed class GetWeatherState {}

final class GetWeatherInitial extends GetWeatherState {}

final class GetWeatherLoading extends GetWeatherState {}

final class GetWeatherLoaded extends GetWeatherState {
  final WeatherModel weatherModel;
  GetWeatherLoaded(this.weatherModel);
}

final class GetWeatherError extends GetWeatherState {
  final String errorMessage;
  GetWeatherError(this.errorMessage);
}
