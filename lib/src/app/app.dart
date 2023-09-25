import 'package:flutter/material.dart';
import 'package:sec_monitor/src/app/ui/theme.dart';
import 'package:sec_monitor/src/constants.dart';
import 'package:sec_monitor/src/presentation/presentation.dart';

class SecMonitorApp extends StatelessWidget {
  const SecMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: ThemeMode.dark,
      title: appTitle,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
