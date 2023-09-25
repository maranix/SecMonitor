import 'package:intl/intl.dart';

String getCurrentTimestamp() {
  final formatter = DateFormat('dd-MM-yyyy hh:mm:ss');

  return formatter.format(DateTime.now());
}

String getTimestampFromEpoch(int epoch) {
  final formatter = DateFormat('dd-MM-yyyy hh:mm:ss');

  return formatter.format(
    DateTime.fromMillisecondsSinceEpoch(epoch),
  );
}
