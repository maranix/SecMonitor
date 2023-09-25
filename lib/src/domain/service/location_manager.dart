import 'package:geolocator/geolocator.dart';
import 'package:sec_monitor/src/data/model/model.dart';

abstract interface class LocationManager {
  factory LocationManager() => _LocationManagerImpl();

  Future<bool> get isServiceAvailable;
  Future<bool> checkAndRequestPermissions();
  Future<LocationData> getCurrentPosition();
  Stream<LocationData> currentPositionStream();
  Future<bool> openSettings();
  Future<bool> openAppSettings();
}

final class _LocationManagerImpl implements LocationManager {
  @override
  Future<bool> get isServiceAvailable => Geolocator.isLocationServiceEnabled();

  @override
  Future<bool> checkAndRequestPermissions() async {
    bool hasPermissions = true;

    if (await isServiceAvailable) {
      final permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        hasPermissions = await _handlePermissionCheck(permission);
      }
    } else {
      throw const LocationServiceDisabledException();
    }

    return hasPermissions;
  }

  @override
  Stream<LocationData> currentPositionStream() {
    return Geolocator.getPositionStream().map(
      (position) => LocationData.fromJson(position.toJson()),
    );
  }

  @override
  Future<LocationData> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    return LocationData.fromJson(position.toJson());
  }

  @override
  Future<bool> openSettings() => Geolocator.openLocationSettings();

  @override
  Future<bool> openAppSettings() => Geolocator.openAppSettings();

  Future<bool> _handlePermissionCheck(LocationPermission permission) async {
    if (permission == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();

      if (result == LocationPermission.deniedForever) {
        throw const PermissionDeniedException('');
      }
    }

    if (permission == LocationPermission.denied) {
      return false;
    }

    return true;
  }
}
