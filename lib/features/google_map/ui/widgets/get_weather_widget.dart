import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/core/theming/styles.dart';
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
        if (state is GetWeatherLoaded) {
          return WeatherLoadedPositionedWidget(weather: state.weatherModel);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class WeatherLoadedPositionedWidget extends StatelessWidget {
  final WeatherModel weather;

  const WeatherLoadedPositionedWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16.w,
      bottom: 40.h,
      child: Container(
        height: 54.h,
        alignment: Alignment.center,
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
              'Temp: ${weather.current!.tempC!.toStringAsFixed(0)}°C',
              style: TextStyles.font16BlackW500,
            ),
          ],
        ),
      ),
    );
  }
}
