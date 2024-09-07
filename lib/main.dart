import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps/core/di/dependancy_injection.dart';
import 'package:google_maps/google_maps_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await dotenv.load(fileName: ".env");
  runApp(const GoogleMapsApp());
}


