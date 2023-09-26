import 'package:sec_monitor/src/data/model/model.dart';

final class MonitorData extends BaseModel {
  const MonitorData({
    required this.captureCount,
    required this.frequency,
    required this.hasConnectivity,
    required this.isCharging,
    required this.chargeLevel,
    required this.location,
    required this.timestamp,
  });

  final int captureCount;
  final int frequency;
  final bool hasConnectivity;
  final bool isCharging;
  final int chargeLevel;
  final LocationData location;
  final int timestamp;

  factory MonitorData.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'capture_count': int captureCount,
          'frequency': int frequency,
          'has_connectivity': bool hasConnectivity,
          'is_charging': bool isCharging,
          'charge_level': int chargeLevel,
          'location': dynamic location,
          'timestamp': int timestamp,
        }) {
      return MonitorData(
        captureCount: captureCount,
        frequency: frequency,
        hasConnectivity: hasConnectivity,
        isCharging: isCharging,
        chargeLevel: chargeLevel,
        location: LocationData.fromJson(location as Map<String, dynamic>),
        timestamp: timestamp,
      );
    } else {
      throw const FormatException();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'capture_count': captureCount,
      'frequency': frequency,
      'has_connectivity': hasConnectivity,
      'is_charging': isCharging,
      'charge_level': chargeLevel,
      'location': location.toJson(),
      'timestamp': timestamp,
    };
  }

  @override
  MonitorData copyWith({
    int? captureCount,
    int? frequency,
    bool? hasConnectivity,
    bool? isCharging,
    int? chargeLevel,
    LocationData? location,
    int? timestamp,
  }) {
    return MonitorData(
      captureCount: captureCount ?? this.captureCount,
      frequency: frequency ?? this.frequency,
      hasConnectivity: hasConnectivity ?? this.hasConnectivity,
      isCharging: isCharging ?? this.isCharging,
      chargeLevel: chargeLevel ?? this.chargeLevel,
      location: location ?? this.location,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  static const empty = MonitorData(
    captureCount: 0,
    frequency: 15,
    hasConnectivity: false,
    isCharging: false,
    chargeLevel: 0,
    location: LocationData(latitude: 0, longitude: 0),
    timestamp: 0,
  );

  @override
  List<Object?> get props => [
        captureCount,
        frequency,
        hasConnectivity,
        isCharging,
        chargeLevel,
        location,
        timestamp,
      ];
}
