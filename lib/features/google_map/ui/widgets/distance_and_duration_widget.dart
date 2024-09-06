import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/theming/styles.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit/google_map_cubit.dart';

class PositionedDistanceAndDurationWidget extends StatelessWidget {
  const PositionedDistanceAndDurationWidget({
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.isDistance,
    required this.icon,
  });

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final bool isDistance;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GoogleMapCubit>();
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      buildWhen: (previous, current) =>
          current is DrawLine || current is ClearPolyLines,
      builder: (context, state) {
        return cubit.isLineDrawn
            ? Positioned(
                top: top ?? 125,
                right: right,
                left: left,
                child: SizedBox(
                  height: 60,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            color: Colors.blue.shade600,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(
                            isDistance
                                ? '${cubit.distanceInKm!.toStringAsFixed(0)} km'
                                : '${cubit.durationInMinutes!.toStringAsFixed(0)} min',
                            style: TextStyles.font14BlackW500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
