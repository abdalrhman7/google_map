import 'package:google_maps/core/netwoking/api_constants.dart';
import 'package:google_maps/core/netwoking/api_result.dart';
import 'package:google_maps/core/netwoking/api_service.dart';
import 'package:google_maps/features/google_map/data/models/weather_model.dart';

class WeatherRepo {
  final ApiService apiService;

  WeatherRepo(this.apiService);

  Future<ApiResult<WeatherModel>> getWeather(String latLng) async {
    try {
      final response = await apiService.getWeather(latLng, ApiConstants.apiKey);
      return ApiResult.success(response);
    } catch (e) {
      return  ApiResult.failure(e.toString());
    }
  }
}
