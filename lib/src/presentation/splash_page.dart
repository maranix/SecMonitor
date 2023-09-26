import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sec_monitor/src/di/di.dart';
import 'package:sec_monitor/src/domain/service/service.dart';
import 'package:sec_monitor/src/presentation/presentation.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  late final LocationManager locationManager;

  void _redirectToHome() {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  Future<void> _showPermissionDeniedDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Permission denied forever',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'Location permissions were denied forever. This app needs access to device location in order to function properly',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => locationManager.openAppSettings(),
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showServiceDisabledDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Location service unavailable',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'This app needs access to location services in order to function properly',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => locationManager.openSettings(),
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    locationManager = getIt<LocationManager>();

    Future.microtask(() async {
      try {
        await locationManager.checkAndRequestPermissions();
      } on PermissionDeniedException {
        await _showPermissionDeniedDialog();
      } on LocationServiceDisabledException {
        await _showServiceDisabledDialog();
      } on Exception {
        await _showPermissionDeniedDialog();
      }

      _redirectToHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
