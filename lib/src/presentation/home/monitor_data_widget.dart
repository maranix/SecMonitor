import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sec_monitor/src/app/ui/ui.dart';
import 'package:sec_monitor/src/data/model/model.dart';
import 'package:sec_monitor/src/domain/notifier/monitor_notifier.dart';

class MonitorData extends StatelessWidget {
  const MonitorData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _CaptureCount(),
        _Frequency(),
        _Connectivity(),
        _Charging(),
        _ChargePercentage(),
        _Location(),
      ],
    );
  }
}

class _CaptureCount extends StatelessWidget {
  const _CaptureCount();

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<ColorsExtension>()!;

    final bodyTextStyle = bodyNormal.copyWith(
      fontWeight: FontWeight.bold,
      color: themeExtension.enabledColor,
    );

    final count = context
        .select<MonitorNotifier, int>((state) => state.data.captureCount);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Capture Count',
            style: bodyTextStyle,
          ),
          Text(
            '$count',
            style: bodyTextStyle,
          ),
        ],
      ),
    );
  }
}

class _Frequency extends StatelessWidget {
  const _Frequency();

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<ColorsExtension>()!;

    final bodyTextStyle = bodyNormal.copyWith(
      fontWeight: FontWeight.bold,
      color: themeExtension.enabledColor,
    );

    final frequency =
        context.select<MonitorNotifier, int>((state) => state.data.frequency);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Frequency (min)',
            style: bodyTextStyle,
          ),
          Text(
            '$frequency',
            style: bodyTextStyle,
          ),
        ],
      ),
    );
  }
}

class _Connectivity extends StatelessWidget {
  const _Connectivity();

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

    final isConnected = context
        .select<MonitorNotifier, bool>((state) => state.data.hasConnectivity);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Connectivity',
            style: bodyTextStyle,
          ),
          Text(
            isConnected ? 'ON' : 'OFF',
            style: isConnected ? bodyTextStyle : bodyTextStyle2,
          ),
        ],
      ),
    );
  }
}

class _Charging extends StatelessWidget {
  const _Charging();

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

    final isCharging =
        context.select<MonitorNotifier, bool>((state) => state.data.isCharging);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Battery Charging',
            style: bodyTextStyle,
          ),
          Text(
            isCharging ? 'ON' : 'OFF',
            style: isCharging ? bodyTextStyle : bodyTextStyle2,
          ),
        ],
      ),
    );
  }
}

class _ChargePercentage extends StatelessWidget {
  const _ChargePercentage();

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<ColorsExtension>()!;

    final bodyTextStyle = bodyNormal.copyWith(
      fontWeight: FontWeight.bold,
      color: themeExtension.enabledColor,
    );

    final percentage =
        context.select<MonitorNotifier, int>((state) => state.data.chargeLevel);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Frequency (min)',
            style: bodyTextStyle,
          ),
          Text(
            '$percentage%',
            style: bodyTextStyle,
          ),
        ],
      ),
    );
  }
}

class _Location extends StatelessWidget {
  const _Location();

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<ColorsExtension>()!;

    final bodyTextStyle = bodyNormal.copyWith(
      fontWeight: FontWeight.bold,
      color: themeExtension.enabledColor,
    );

    final location = context
        .select<MonitorNotifier, LocationData>((state) => state.data.location);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Frequency (min)',
            style: bodyTextStyle,
          ),
          Text(
            '${location.latitude.toStringAsFixed(6)}, ${location.longitude.toStringAsFixed(6)}',
            style: bodyTextStyle,
          ),
        ],
      ),
    );
  }
}
