
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps/core/netwoking/api_service.dart';
import 'package:google_maps/core/netwoking/dio_factory.dart';
import 'package:google_maps/features/google_map/data/repos/weather_repo.dart';
import 'package:google_maps/features/google_map/logic/google_map_cubit.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<WeatherRepo>(() => WeatherRepo(getIt()));
  getIt.registerFactory<GoogleMapCubit>(() => GoogleMapCubit(getIt()));


}
