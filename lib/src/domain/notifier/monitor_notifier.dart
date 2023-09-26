import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sec_monitor/src/data/model/model.dart';
import 'package:sec_monitor/src/data/repository/data_repository.dart';
import 'package:sec_monitor/src/di/di.dart';
import 'package:sec_monitor/src/domain/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitorNotifier extends ChangeNotifier {
  MonitorNotifier({
    required ConnectivityManager connectivityManager,
    required BatteryManager batteryManager,
    required LocationManager locationManager,
    DataRepository? repository,
  })  : _connectivityManager = connectivityManager,
        _batteryManager = batteryManager,
        _locationManager = locationManager,
        _repository = repository ?? DataRepository() {
    _init();
  }

  late MonitorData _monitorData;
  MonitorData get data => _monitorData;
  final ConnectivityManager _connectivityManager;
  final BatteryManager _batteryManager;
  final LocationManager _locationManager;
  final DataRepository _repository;

  StreamSubscription<void>? _dataSyncStream;
  StreamSubscription<bool>? _connectivityStream;
  StreamSubscription<bool>? _chargingStateStream;
  StreamSubscription<LocationData>? _locationPositionStream;
  StreamSubscription<int>? _timestampStream;

  void _init() {
    _monitorData = _restoreSession();
    _startDataStreams();
  }

  void incrementCaptureCount() {
    _monitorData = _monitorData.copyWith(
      captureCount: _monitorData.captureCount + 1,
    );

    _saveSession();
    notifyListeners();
  }

  void updateFrequency(int value) {
    _monitorData = _monitorData.copyWith(frequency: value);
    _restartDataSyncStream();
    notifyListeners();
  }

  Future<void> captureData() async {
    _repository.syncData(_monitorData);
    incrementCaptureCount();
  }

  void _startDataStreams() {
    _connectivityStream = _connectivityManager.connectivityStateStream().listen((isConnected) {
      _monitorData = _monitorData.copyWith(hasConnectivity: isConnected);
      notifyListeners();
    });

    _chargingStateStream = _batteryManager.chargingStateStream().listen((isCharging) async {
      _monitorData = _monitorData.copyWith(
        isCharging: isCharging,
        chargeLevel: await _batteryManager.chargeLevel(),
      );
      notifyListeners();
    });

    _locationPositionStream = _locationManager.currentPositionStream().listen((location) {
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

    _dataSyncStream = Stream.periodic(
      Duration(seconds: _monitorData.frequency),
      (_) async {
        final chargeLevel = await _batteryManager.chargeLevel();
        _monitorData = _monitorData.copyWith(
          chargeLevel: chargeLevel,
          hasConnectivity: await _connectivityManager.isConnected(),
        );
        captureData();
      },
    ).listen((_) {});
  }

  void _restartDataSyncStream() {
    _dataSyncStream?.cancel();

    _dataSyncStream = Stream.periodic(
      Duration(seconds: _monitorData.frequency),
      (_) async {
        final chargeLevel = await _batteryManager.chargeLevel();
        _monitorData = _monitorData.copyWith(chargeLevel: chargeLevel);
        await captureData();
      },
    ).listen((_) {});
  }

  MonitorData _restoreSession() {
    final instance = getIt<SharedPreferences>();

    final data = instance.getString('monitor_data');

    if (data != null) {
      final json = jsonDecode(data) as Map<String, dynamic>;

      return MonitorData.fromJson(json);
    }

    return MonitorData.empty.copyWith(
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  void _saveSession() {
    final instance = getIt<SharedPreferences>();

    final data = jsonEncode(_monitorData.toJson());

    instance.setString('monitor_data', data);
  }

  void _stopDataStreams() {
    _connectivityStream?.cancel();
    _chargingStateStream?.cancel();
    _locationPositionStream?.cancel();
    _timestampStream?.cancel();
    _dataSyncStream?.cancel();
  }

  Future<void> close() async {
    _stopDataStreams();
    await _repository.awaitAllPendingWrites();
  }
}
