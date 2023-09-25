import 'package:get_it/get_it.dart';
import 'package:sec_monitor/src/domain/notifier/notifier.dart';
import 'package:sec_monitor/src/domain/service/service.dart';

final getIt = GetIt.instance;

void dependencySetup() {
  final connectivityManager = ConnectivityManager.internet();
  final batteryManager = BatteryManager();
  final locationManger = LocationManager();

  final monitorNotifier = MonitorNotifier(
    connectivityManager: connectivityManager,
    batteryManager: batteryManager,
    locationManager: locationManger,
  );

  getIt.registerLazySingleton<ConnectivityManager>(() => connectivityManager,
      instanceName: 'Internet');
  getIt.registerLazySingleton<BatteryManager>(() => batteryManager);
  getIt.registerLazySingleton<LocationManager>(() => locationManger);
  getIt.registerLazySingleton<MonitorNotifier>(
    () => monitorNotifier,
    dispose: (instance) => instance.close(),
  );
}

