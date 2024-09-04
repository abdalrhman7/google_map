import 'package:flutter/material.dart';
import 'package:google_maps/core/widgets/custom_drawer.dart';
import 'package:google_maps/features/google_map/ui/widgets/distance_and_duration_widget.dart';
import 'package:google_maps/features/google_map/ui/widgets/draw_route_line_bloc_builder.dart';
import 'package:google_maps/features/google_map/ui/widgets/get_weather_widget.dart';
import 'package:google_maps/features/google_map/ui/widgets/go_to_current_location_widget.dart';
import 'package:google_maps/features/google_map/ui/widgets/google_map_bloc_builder.dart';
import 'package:google_maps/features/google_map/ui/widgets/location_permission_error_bloc_builder.dart';
import 'package:google_maps/features/google_map/ui/widgets/open_drawer_button.dart';
import 'widgets/google_places_form_field_widget.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          GoogleMapBlocBuilder(),
          Padding(
            padding: EdgeInsets.only(top: 66, left: 14, right: 14),
            child: Row(
              children: [
                OpenDrawerButton(),
                SizedBox(width: 6),
                Expanded(child: GooglePlacesFormFieldWidget()),
              ],
            ),
          ),
          Positioned(
            left: 16,
            bottom: 40,
            child: GoToCurrentLocationWidget(),
          ),
          DrawRouteLineBlocBuilder(),
          LocationPermissionErrorBlocBuilder(),
          PositionedDistanceAndDurationWidget(
            right: 20,
            icon: Icons.directions_car_filled,
            isDistance: true,
          ),
          PositionedDistanceAndDurationWidget(
            left: 20,
            icon: Icons.access_time_filled_outlined,
            isDistance: false,
          ),
          GetWeatherWidget()
        ],
      ),
    );
  }
}


