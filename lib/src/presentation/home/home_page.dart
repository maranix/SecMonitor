import 'package:flutter/material.dart';
import 'package:sec_monitor/src/app/ui/ui.dart';
import 'package:sec_monitor/src/domain/service/service.dart';
import 'package:sec_monitor/src/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

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
                  Text(
                    getCurrentTimestamp(),
                    style: subTitleTextStyle,
                  ),
                ],
              ),
              const Spacer(),
              const MonitorData(),
              const Spacer(),
              ElevatedButton(
                onPressed: () => {},
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

class MonitorData extends StatefulWidget {
  const MonitorData({super.key});

  @override
  State<MonitorData> createState() => _MonitorDataState();
}

class _MonitorDataState extends State<MonitorData> {
  late final ConnectivityManager connectivityManager;
  late final BatteryManager batteryManager;

  @override
  void initState() {
    super.initState();

    connectivityManager = ConnectivityManager.internet();
    batteryManager = BatteryManager();
  }

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<ColorsExtension>()!;

    final bodyTextStyle = bodyNormal.copyWith(
      fontWeight: FontWeight.bold,
      color: themeExtension.enabledColor,
    );

    final bodyTextStyle2 = bodyNormal.copyWith(
      fontWeight: FontWeight.bold,
      color: themeExtension.disabledColor,
    );

    return Column(
      children: [
        MonitorDataRow(
          title: 'Capture Count',
          child: Text(
            '0',
            style: bodyTextStyle,
          ),
        ),
        MonitorDataRow(
          title: 'Frequency (min)',
          child: Text(
            '15',
            style: bodyTextStyle,
          ),
        ),
        FutureBuilder(
          future: connectivityManager.isConnected(),
          builder: (context, snapshot) {
            return switch (snapshot.data) {
              true => MonitorDataRow(
                  title: 'Connectivity',
                  child: Text(
                    'ON',
                    style: bodyTextStyle,
                  ),
                ),
              _ => MonitorDataRow(
                  title: 'Connectivity',
                  child: Text(
                    'OFF',
                    style: bodyTextStyle2,
                  ),
                )
            };
          },
        ),
        FutureBuilder(
          future: batteryManager.isCharging(),
          builder: (context, snapshot) {
            return switch (snapshot.data) {
              true => MonitorDataRow(
                  title: 'Battery Charging',
                  child: Text(
                    'ON',
                    style: bodyTextStyle,
                  ),
                ),
              _ => MonitorDataRow(
                  title: 'Battery Charging',
                  child: Text(
                    'OFF',
                    style: bodyTextStyle2,
                  ),
                )
            };
          },
        ),
        FutureBuilder(
          future: batteryManager.chargeLevel(),
          builder: (context, snapshot) {
            return MonitorDataRow(
              title: 'Battery Charging',
              child: Text(
                '${snapshot.data}%',
                style: bodyTextStyle,
              ),
            );
          },
        ),
        MonitorDataRow(
          title: 'Location',
          child: Text(
            '31.684585, 58.632866',
            style: bodyTextStyle,
          ),
        ),
      ],
    );
  }
}

class MonitorDataRow extends StatelessWidget {
  const MonitorDataRow({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: bodyNormal.copyWith(
              fontWeight: FontWeight.bold,
              color:
                  Theme.of(context).extension<ColorsExtension>()!.enabledColor,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
