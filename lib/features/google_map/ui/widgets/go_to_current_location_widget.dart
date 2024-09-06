

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit/google_map_cubit.dart';

class GoToCurrentLocationWidget extends StatelessWidget {
  const GoToCurrentLocationWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GoogleMapCubit>();
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
        height: 50.h,
        width: 50.w,
        child: const Icon(Icons.location_on, color: Colors.red , size: 30,),
      ),
    );
  }
}
