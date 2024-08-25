


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit.dart';

class DistanceAndDurationWidget extends StatelessWidget {
  const DistanceAndDurationWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GoogleMapCubit>();
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      buildWhen: (previous, current) => current is DrawLine || current is ClearPolyLines,
      builder: (context, state) {
        return cubit.isLineDrawn ? Positioned(
          top: 125,
          right: 20,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration:  const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Text('Distance: ${cubit.distanceInKm!.toStringAsFixed(2)} km ,' , style: const TextStyle(fontSize: 15 , fontWeight: FontWeight.w500),),
                const SizedBox(width: 6),
                Text('Duration: ${cubit.durationInMinutes} min', style: const TextStyle(fontSize: 15 , fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ) : const SizedBox.shrink();

      },
    );
  }
}