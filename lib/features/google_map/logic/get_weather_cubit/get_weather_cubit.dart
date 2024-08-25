import 'package:bloc/bloc.dart';
import 'package:google_maps/features/google_map/data/models/weather_model.dart';
import 'package:google_maps/features/google_map/data/repos/weather_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'get_weather_state.dart';

class GetWeatherCubit extends Cubit<GetWeatherState> {
  GetWeatherCubit(this.weatherRepo) : super(GetWeatherInitial());

 final  WeatherRepo weatherRepo;


  void getWeather({LatLng? latLng}) async {
    emit(GetWeatherLoading());
    var result = await weatherRepo.getWeather('${latLng!.latitude},${latLng.longitude}');
    result.when(
      success: (data) => emit(GetWeatherLoaded(data)),
      failure: (message) => emit(GetWeatherError(message)),
    );
  }
}
