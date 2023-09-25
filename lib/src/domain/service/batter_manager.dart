import 'package:battery_plus/battery_plus.dart';

abstract interface class BatteryManager {
  factory BatteryManager({Battery? battery}) =>
      _BatteryManagerImpl(battery: battery);

  Future<bool> isCharging();
  Future<int> chargeLevel();
  Stream<bool> chargingStateStream();
}

final class _BatteryManagerImpl implements BatteryManager {
  _BatteryManagerImpl({
    Battery? battery,
  }) : _battery = battery ?? Battery();

  final Battery _battery;

  @override
  Future<int> chargeLevel() {
    return _battery.batteryLevel;
  }

  @override
  Future<bool> isCharging() async {
    return switch (await _battery.batteryState) {
      BatteryState.charging => true,
      _ => false,
    };
  }

  @override
  Stream<bool> chargingStateStream() {
    return _battery.onBatteryStateChanged.map(
      (state) => switch (state) {
        BatteryState.charging => true,
        _ => false,
      },
    );
  }
}
