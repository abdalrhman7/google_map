import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps/core/di/dependancy_injection.dart';
import 'package:google_maps/core/routing/app_router.dart';
import 'package:google_maps/features/google_map/data/repos/weather_repo.dart';
import 'core/routing/routes.dart';
import 'features/google_map/logic/get_weather_cubit/get_weather_cubit.dart';
import 'features/google_map/logic/google_map_cubit/google_map_cubit.dart';
import 'features/google_map/ui/google_map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await dotenv.load(fileName: ".env");
  runApp(const GoogleMapsApp());
}

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: Routes.mapScreen,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

