import 'package:get_it/get_it.dart';
import 'package:sec_monitor/src/domain/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> dependencySetup() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  final connectivityManager = ConnectivityManager.internet();
  final batteryManager = BatteryManager();
  final locationManger = LocationManager();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<ConnectivityManager>(() => connectivityManager, instanceName: 'Internet');
  getIt.registerLazySingleton<BatteryManager>(() => batteryManager);
  getIt.registerLazySingleton<LocationManager>(() => locationManger);
}
