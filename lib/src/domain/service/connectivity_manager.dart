import 'dart:developer' as dev;
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

abstract interface class ConnectivityManager {
  const ConnectivityManager();

  factory ConnectivityManager.internet({Connectivity? connectivity}) =>
      _InternetConnectivityManager(connectivity: connectivity);

  Future<bool> isConnected();
  Future<bool> ping();
  Stream<bool> connectivityStateStream();
}

final class _InternetConnectivityManager implements ConnectivityManager {
  _InternetConnectivityManager({
    Connectivity? connectivity,
  }) : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

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

  @override
  Stream<bool> connectivityStateStream() {
    return _connectivity.onConnectivityChanged.asyncMap(
      (event) async {
        return switch (event) {
          ConnectivityResult.none => false,
          _ => await isConnected(),
        };
      },
    );
  }
}
