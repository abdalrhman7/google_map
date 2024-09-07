import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/core/utlis/spacing.dart';
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
    return  Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const GoogleMapBlocBuilder(),
          Padding(
            padding:  EdgeInsets.only(top: 64.h, left: 14.w, right: 14.w),
            child: Row(
              children: [
                const OpenDrawerButton(),
                verticalSpacing(4),
                const Expanded(child: GooglePlacesFormFieldWidget()),
              ],
            ),
          ),
           Positioned(
            left: 16.w,
            bottom: 40.h,
            child: const GoToCurrentLocationWidget(),
          ),
          const DrawRouteLineBlocBuilder(),
          const LocationPermissionErrorBlocBuilder(),
           PositionedDistanceAndDurationWidget(
            right: 20.w,
            icon: Icons.directions_car_filled,
            isDistance: true,
          ),
           PositionedDistanceAndDurationWidget(
            left: 20.w,
            icon: Icons.access_time_filled_outlined,
            isDistance: false,
          ),
          const GetWeatherWidget()
        ],
      ),
    );
  }
}


