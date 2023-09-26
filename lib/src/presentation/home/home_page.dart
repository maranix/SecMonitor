import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sec_monitor/src/app/ui/ui.dart';
import 'package:sec_monitor/src/di/di.dart';
import 'package:sec_monitor/src/domain/notifier/notifier.dart';
import 'package:sec_monitor/src/presentation/home/monitor_data_widget.dart';
import 'package:sec_monitor/src/presentation/home/timestamp_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MonitorNotifier>.value(
      value: getIt.get<MonitorNotifier>(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<ColorsExtension>()!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'SECQUR',
                          style: titleTextStyle.copyWith(
                            color: themeExtension.primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'AI',
                          style: titleTextStyle.copyWith(
                            color: themeExtension.accentColor,
                          ),
                        ),
                        TextSpan(
                          text: 'SE',
                          style: titleTextStyle.copyWith(
                            color: themeExtension.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const TimestampWidget(),
                ],
              ),
              const Spacer(),
              const MonitorData(),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.read<MonitorNotifier>().captureData(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeExtension.primaryColor,
                ),
                child: Text(
                  'Manual Data Refresh',
                  style: bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
