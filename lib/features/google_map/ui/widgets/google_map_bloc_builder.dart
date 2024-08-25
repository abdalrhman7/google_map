import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapBlocBuilder extends StatelessWidget {
  const GoogleMapBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GoogleMapCubit>();
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      buildWhen: (previous, current) => current is UpdateCurrentLocation || current is UpdateSearchedLocation || current is ClearPolyLines || current is DrawLine,
      builder: (context, state) {
        return GoogleMap(
          polylines: cubit.polyLines,
          onMapCreated: (controller) async{
            cubit.mapController = controller;
           await cubit.updateCurrentLocation();
           cubit.getWeather();
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 0,
          ),
          markers: cubit.markers,
        );
      },
    );
  }
}