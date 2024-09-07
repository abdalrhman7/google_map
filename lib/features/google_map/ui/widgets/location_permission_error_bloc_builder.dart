import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit/google_map_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

import 'custom_alert_dialog.dart';

class LocationPermissionErrorBlocBuilder extends StatelessWidget {
  const LocationPermissionErrorBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GoogleMapCubit>();
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      buildWhen: (previous, current) => current is LocationServiceExceptionError || current is LocationPermissionExceptionError,
      builder: (context, state) {
        if (state is LocationServiceExceptionError) {
          return Positioned(
            child: CustomAlertDialog(
              errorMessage: state.errorMessage,
              buttonText: context.localization.openLocation,
              onPressed: () {
                cubit.updateCurrentLocation();
              },
            ),
          );
        }
        if (state is LocationPermissionExceptionError) {
          return Positioned(
            child: CustomAlertDialog(
              errorMessage: state.errorMessage,
              buttonText: context.localization.givePermission,
              onPressed: () async {
                bool isPermissionGranted = await openAppSettings();
                if (isPermissionGranted) {
                  cubit.updateCurrentLocation();
                }
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}