import 'package:get_it/get_it.dart';
import 'package:sec_monitor/src/domain/service/service.dart';

final getIt = GetIt.instance;

void dependencySetup() {
  getIt.registerLazySingleton<ConnectivityManager>(
      () => ConnectivityManager.internet());
  getIt.registerLazySingleton<BatteryManager>(() => BatteryManager());
  getIt.registerLazySingleton<LocationManager>(() => LocationManager());
}

