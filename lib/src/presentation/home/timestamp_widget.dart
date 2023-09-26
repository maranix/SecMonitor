import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sec_monitor/src/app/ui/ui.dart';
import 'package:sec_monitor/src/domain/notifier/notifier.dart';
import 'package:sec_monitor/src/utils/utils.dart';

class TimestampWidget extends StatelessWidget {
  const TimestampWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timestamp = context.select<MonitorNotifier, int>(
      (state) => state.data.timestamp,
    );

    return Text(
      getTimestampFromEpoch(timestamp),
      style: subTitleTextStyle,
    );
  }
}
