import 'dart:developer' as dev;
import 'dart:io';

import 'package:logging/logging.dart';

abstract interface class ConnectivityManager {
  const ConnectivityManager();

  factory ConnectivityManager.internet() =>
      const _InternetConnectivityManager();

  Future<bool> isConnected();
  Future<bool> ping();
}

final class _InternetConnectivityManager implements ConnectivityManager {
  const _InternetConnectivityManager();

  @override
  Future<bool> isConnected() async {
    bool hasConnection = false;

    try {
      if (await ping()) {
        hasConnection = true;
      }
    } on StateError catch (e) {
      dev.log(
        "Address returned an empty IP, Internet capabilities are offline",
        level: Level.WARNING.value,
        error: e,
      );
    } on SocketException catch (e) {
      dev.log(
        "Couldn't lookup up address, Internet capabilities are offline",
        level: Level.WARNING.value,
        error: e,
      );
    } on Exception catch (e) {
      dev.log(
        "An unkown error occured while looking up the address, Internet capabilities are offline",
        level: Level.WARNING.value,
        error: e,
      );
    }

    return hasConnection;
  }

  @override
  Future<bool> ping() async {
    final result = await InternetAddress.lookup('example.com');

    return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
  }
}
