import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/helper/extensions.dart';
import 'package:google_maps/core/routing/routes.dart';
import 'package:google_maps/features/splash/logic/connectivity_cubit.dart';
import 'package:google_maps/features/splash/ui/widgets/no_internet_snackbar_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state is NoInternetConnection) {
          ScaffoldMessenger.of(context).showSnackBar(
            noInternetSnackBarWidget(context),
          );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
        context.pushReplacementNamed(Routes.mapScreen);
      },
      child: const Scaffold(),
    );
  }
}
