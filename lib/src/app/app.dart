import 'package:flutter/material.dart';
import 'package:sec_monitor/src/app/ui/theme.dart';
import 'package:sec_monitor/src/constants.dart';
import 'package:sec_monitor/src/presentation/presentation.dart';
import 'package:sec_monitor/src/presentation/splash_page.dart';

class SecMonitorApp extends StatelessWidget {
  const SecMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: ThemeMode.dark,
      title: appTitle,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
