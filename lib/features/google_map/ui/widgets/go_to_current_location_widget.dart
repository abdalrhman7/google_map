

import 'package:flutter/material.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit.dart';

class GoToCurrentLocationWidget extends StatelessWidget {
  const GoToCurrentLocationWidget({
    super.key,
    required this.cubit,
  });

  final GoogleMapCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cubit.updateCurrentLocation();
      },
      child: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            color: Colors.grey,
            width: 1.2,
          ),
        ),
        height: 50,
        width: 50,
        child: const Icon(Icons.location_on, color: Colors.red , size: 30,),
      ),
    );
  }
}
