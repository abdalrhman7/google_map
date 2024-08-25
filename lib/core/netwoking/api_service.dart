import 'package:dio/dio.dart';
import 'package:google_maps/core/netwoking/api_constants.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/google_map/data/models/weather_model.dart';


part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiConstants.currentWeather)
  Future<WeatherModel> getWeather(
    @Query('q') String latLng,
    @Query('key') String apiKey,
  );
}
