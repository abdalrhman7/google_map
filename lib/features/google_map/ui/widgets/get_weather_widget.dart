import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/utlis/string_constants.dart';
import 'package:google_maps/features/google_map/data/models/weather_model.dart';
import 'package:google_maps/features/google_map/logic/get_weather_cubit/get_weather_cubit.dart';

class GetWeatherWidget extends StatelessWidget {
  const GetWeatherWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeatherCubit, GetWeatherState>(
      builder: (context, state) {
        if (state is GetWeatherLoading) {
          return const WeatherLoadingPositionedWidget();
        }
        if (state is GetWeatherLoaded) {
          return WeatherLoadedPositionedWidget(weather: state.weatherModel);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class WeatherLoadingPositionedWidget extends StatelessWidget {
  const WeatherLoadingPositionedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 100,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: Colors.grey,
            width: 1.2,
          ),
        ),
        child: const Text(StringConstants.gettingWeather, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

class WeatherLoadedPositionedWidget extends StatelessWidget {
  final WeatherModel weather;

  const WeatherLoadedPositionedWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 100,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.grey,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Text(
              '${StringConstants.currentTemp} ${weather.current!.tempC!.toStringAsFixed(0)}°C',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
