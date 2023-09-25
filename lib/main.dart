import 'package:flutter/material.dart';
import 'package:sec_monitor/src/app/app.dart';
import 'package:sec_monitor/src/di/di.dart';

void main() {
  dependencySetup();

  runApp(const SecMonitorApp());
}
