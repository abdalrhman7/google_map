import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/theming/styles.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit/google_map_cubit.dart';

class DrawRouteLineBlocBuilder extends StatelessWidget {
  const DrawRouteLineBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GoogleMapCubit>();
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      buildWhen: (previous, current) =>
          current is DrawLine ||
          current is ClearPolyLines ||
          current is UpdateCurrentLocation ||
          current is UpdateSearchedLocation,
      builder: (context, state) {
        return cubit.isSearched
            ? GetDirectionsOrCancelDirections(
                title: 'Directions',
                onPressed: cubit.drawLineAndMoveCamera,
              )
            : cubit.isLineDrawn
                ? GetDirectionsOrCancelDirections(
                    title: 'Cancel',
                    onPressed: () async {
                      await cubit.updateCurrentLocation();
                      cubit.clearPolyLinesAndMarkers();
                    },
                    isDrawLine: false,
                  )
                : const SizedBox.shrink();
      },
    );
  }
}

class GetDirectionsOrCancelDirections extends StatelessWidget {
  const GetDirectionsOrCancelDirections({
    super.key,
    this.onPressed,
    required this.title,
    this.isDrawLine = true,
  });

  final void Function()? onPressed;
  final String title;
  final bool isDrawLine;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 100,
      child: GestureDetector(
        onTap: onPressed,
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
          child: Row(
            children: [
              isDrawLine
                  ? const Icon(
                      Icons.directions,
                      color: Colors.white,
                    )
                  : const SizedBox.shrink(),
              isDrawLine ? const SizedBox(width: 8) : const SizedBox.shrink(),
              Text(
                title,
                style: TextStyles.font16BlackW500.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
