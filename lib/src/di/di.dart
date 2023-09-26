import 'package:get_it/get_it.dart';
import 'package:sec_monitor/src/domain/service/service.dart';

final getIt = GetIt.instance;

void dependencySetup() {
  final connectivityManager = ConnectivityManager.internet();
  final batteryManager = BatteryManager();
  final locationManger = LocationManager();

  getIt.registerLazySingleton<ConnectivityManager>(() => connectivityManager, instanceName: 'Internet');
  getIt.registerLazySingleton<BatteryManager>(() => batteryManager);
  getIt.registerLazySingleton<LocationManager>(() => locationManger);
}
