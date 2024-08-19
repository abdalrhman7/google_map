import 'package:flutter/material.dart';


import 'features/google_map/ui/google_map_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  runApp(const GoogleMapsApp());
}

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GoogleMapScreen(),
    );
  }
}

