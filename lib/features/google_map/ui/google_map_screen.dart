import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit.dart';
import 'package:google_maps/features/google_map/ui/widgets/go_to_current_location_widget.dart';
import 'package:google_maps/features/google_map/ui/widgets/location_permission_error_bloc_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'widgets/google_places_form_field_widget.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GoogleMapCubit>();
    return Scaffold(
      body: BlocBuilder<GoogleMapCubit, GoogleMapState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                polylines: cubit.polyLines,
                onMapCreated: (controller) {
                  cubit.mapController = controller;
                  cubit.updateCurrentLocation();
                },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 0,
                ),
                markers: cubit.markers,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 66, left: 20, right: 20),
                child: GooglePlacesFormFieldWidget(cubit: cubit),
              ),
              Positioned(
                left: 16,
                bottom: 40,
                child: GoToCurrentLocationWidget(cubit: cubit),
              ),
              if(cubit.isSearched)
                Positioned(
                  left: 16,
                  bottom: 100,
                  child: GestureDetector(
                    onTap: () {
                       cubit.drawRoute();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      height: 50,
                      alignment: Alignment.center,
                      child: const Row(
                        children: [
                          Icon(Icons.directions, color: Colors.white,),
                          SizedBox(width: 8),
                          Text('Directions',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight
                                .w500, color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                ),
              LocationPermissionErrorBlocBuilder(cubit: cubit),
            ],
          );
        },
      ),
    );
  }
}




