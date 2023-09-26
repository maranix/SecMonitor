import 'package:flutter/material.dart';
import 'package:sec_monitor/src/app/app.dart';
import 'package:sec_monitor/src/di/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dependencySetup();

  runApp(const SecMonitorApp());
}
