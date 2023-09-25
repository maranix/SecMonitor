import 'package:sec_monitor/src/data/model/model.dart';

final class LocationData extends BaseModel {
  const LocationData({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory LocationData.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'latitude': double lat,
          'longitude': double long,
        }) {
      return LocationData(
        latitude: lat,
        longitude: long,
      );
    } else {
      throw const FormatException();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  LocationData copyWith({
    double? latitude,
    double? longitude,
  }) {
    return LocationData(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<double> get props => [
        latitude,
        longitude,
      ];
}
