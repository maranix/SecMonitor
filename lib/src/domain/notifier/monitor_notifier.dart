import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sec_monitor/src/data/model/model.dart';
import 'package:sec_monitor/src/domain/service/service.dart';

class MonitorNotifier extends ChangeNotifier {
  MonitorNotifier({
    required ConnectivityManager connectivityManager,
    required BatteryManager batteryManager,
    required LocationManager locationManager,
  })  : _connectivityManager = connectivityManager,
        _batteryManager = batteryManager,
        _locationManager = locationManager {
    _init();
  }

  late MonitorData _monitorData;
  MonitorData get data => _monitorData;

  final ConnectivityManager _connectivityManager;
  final BatteryManager _batteryManager;
  final LocationManager _locationManager;

  StreamSubscription<bool>? _connectivityStream;
  StreamSubscription<bool>? _chargingStateStream;
  StreamSubscription<LocationData>? _locationPositionStream;
  StreamSubscription<int>? _timestampStream;

  void _init() {
    _monitorData = MonitorData.empty;

    _connectivityStream =
        _connectivityManager.connectivityStateStream().listen((isConnected) {
      _monitorData = _monitorData.copyWith(hasConnectivity: isConnected);
      notifyListeners();
    });

    _chargingStateStream =
        _batteryManager.chargingStateStream().listen((isCharging) async {
      _monitorData = _monitorData.copyWith(
        isCharging: isCharging,
        chargeLevel: await _batteryManager.chargeLevel(),
      );
      notifyListeners();
    });

    _locationPositionStream =
        _locationManager.currentPositionStream().listen((location) {
      _monitorData = _monitorData.copyWith(location: location);
      notifyListeners();
    });

    _timestampStream = Stream.periodic(
      const Duration(seconds: 1),
      (count) => DateTime.now().millisecondsSinceEpoch + count,
    ).listen((epoch) {
      _monitorData = _monitorData.copyWith(timestamp: epoch);
      notifyListeners();
    });
  }

  void close() {
    _connectivityStream?.cancel();
    _chargingStateStream?.cancel();
    _locationPositionStream?.cancel();
    _timestampStream?.cancel();
  }
}
