import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/core/di/dependancy_injection.dart';
import 'package:google_maps/core/routing/routes.dart';
import 'package:google_maps/features/addresses/logic/manage_address_cubit/manage_address_cubit.dart';
import 'package:google_maps/features/addresses/ui/add_address_screen.dart';
import 'package:google_maps/features/addresses/ui/my_addresses_screen.dart';
import 'package:google_maps/features/google_map/data/repos/weather_repo.dart';
import 'package:google_maps/features/google_map/logic/get_weather_cubit/get_weather_cubit.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit/google_map_cubit.dart';
import 'package:google_maps/features/google_map/ui/google_map_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.mapScreen:
        return MaterialPageRoute(
          builder: (_) =>
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => GoogleMapCubit()),
                  BlocProvider(
                      create: (context) =>
                          GetWeatherCubit(getIt<WeatherRepo>())),
                ],
                child: const GoogleMapScreen(),
              ),
        );

      case Routes.myAddressesScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => ManageAddressCubit()..loadSavedAddresses(),
                child: const MyAddressesScreen(),
              ),
        );

      case Routes.addAddressScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(
                value: arguments as ManageAddressCubit,
                child: const AddAddressScreen(),
              ),
        );

      default:
        return null;
    }
  }
}
