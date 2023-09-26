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

  StreamSubscription<void>? _dataSyncStream;
  StreamSubscription<bool>? _connectivityStream;
  StreamSubscription<bool>? _chargingStateStream;
  StreamSubscription<LocationData>? _locationPositionStream;
  StreamSubscription<int>? _timestampStream;

  void _init() {
    _monitorData = MonitorData.empty.copyWith(timestamp: DateTime.now().millisecondsSinceEpoch);
    _startDataStreams();
  }

  void incrementCaptureCount() {
    _monitorData = _monitorData.copyWith(
      captureCount: _monitorData.captureCount + 1,
    );

    notifyListeners();
  }

  void updateFrequency(int value) {
    _monitorData = _monitorData.copyWith(frequency: value);
    _restartDataSyncStream();
    notifyListeners();
  }

  Future<void> captureData() async {
    incrementCaptureCount();
  }

  void _startDataStreams() {
    _connectivityStream = _connectivityManager.connectivityStateStream().listen((isConnected) {
      _monitorData = _monitorData.copyWith(hasConnectivity: isConnected);
    });

    _chargingStateStream = _batteryManager.chargingStateStream().listen((isCharging) async {
      _monitorData = _monitorData.copyWith(
        isCharging: isCharging,
        chargeLevel: await _batteryManager.chargeLevel(),
      );
    });

    _locationPositionStream = _locationManager.currentPositionStream().listen((location) {
      _monitorData = _monitorData.copyWith(location: location);
    });

    _timestampStream = Stream.periodic(
      const Duration(seconds: 1),
      (count) => DateTime.now().millisecondsSinceEpoch + count,
    ).listen((epoch) {
      _monitorData = _monitorData.copyWith(timestamp: epoch);
    });

    _dataSyncStream = Stream.periodic(
      Duration(seconds: _monitorData.frequency),
      (_) async {
        await captureData();
      },
    ).listen((_) {});
  }

  void _restartDataSyncStream() {
    _dataSyncStream?.cancel();

    _dataSyncStream = Stream.periodic(
      Duration(seconds: _monitorData.frequency),
      (_) async {
        await captureData();
      },
    ).listen((_) {});
  }

  void _stopDataStreams() {
    _connectivityStream?.cancel();
    _chargingStateStream?.cancel();
    _locationPositionStream?.cancel();
    _timestampStream?.cancel();
    _dataSyncStream?.cancel();
  }

  void close() {
    _stopDataStreams();
  }
}
