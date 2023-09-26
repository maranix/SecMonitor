import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sec_monitor/firebase_options.dart';
import 'package:sec_monitor/src/app/app.dart';
import 'package:sec_monitor/src/di/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Future.wait([
    FirebaseAuth.instance.signInAnonymously(),
    dependencySetup(),
  ]);

  runApp(const SecMonitorApp());
}
