import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityCubit() : super(ConnectivityInitial());

  void checkConnectivity() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        emit(NoInternetConnection());
      } else {
        emit(HasInternetConnection());
      }
    });
  }

  Future<bool> hasConnection() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.none);
  }
}