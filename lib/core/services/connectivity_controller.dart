import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityController {
  ConnectivityController._();

  static final ConnectivityController instance = ConnectivityController._();

  /// Notifier for connection status: value to listen & switch UI
  ValueNotifier<bool> isConnected = ValueNotifier(true);

  /// Initialize connectivity monitoring
  Future<void> init() async {
    final result = await Connectivity().checkConnectivity();
    await isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen(isInternetConnected);
  }

  Future<bool> isInternetConnected(ConnectivityResult? result) async {
    final hasInternet = await hasRealInternetConnection();
    if (result == ConnectivityResult.none) {
      isConnected.value = false;
      return false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        hasInternet) {
      isConnected.value = true;
      return true;
    }
    return false;
  }
}

Future<bool> hasRealInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } on SocketException catch (_) {
    return false;
  }
}
