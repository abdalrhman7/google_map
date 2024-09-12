import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/features/google_map/logic/get_weather_cubit/get_weather_cubit.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit/google_map_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapBlocBuilder extends StatelessWidget {
  const GoogleMapBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var googleMapCubit = context.read<GoogleMapCubit>();
    var weatherCubit = context.read<GetWeatherCubit>();
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      buildWhen: (previous, current) =>
          current is UpdateCurrentLocation ||
          current is UpdateSearchedLocation ||
          current is ClearPolyLines ||
          current is DrawLine,
      builder: (context, state) {
        return GoogleMap(
          polylines: googleMapCubit.polyLines,
          onMapCreated: (controller) async {
            googleMapCubit.mapController = controller;
            await googleMapCubit.updateCurrentLocation();
            weatherCubit.getWeather(latLng: googleMapCubit.currentLocation);
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 0,
          ),
          markers: googleMapCubit.markers,
          zoomControlsEnabled: false,
        );
      },
    );
  }
}
