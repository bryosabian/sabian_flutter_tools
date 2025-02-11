import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SabianNetwork {
  static SabianNetwork? _instance;

  late InternetConnection checker;

  late Connectivity connectivity;

  SabianNetwork._({InternetConnection? checker, Connectivity? connectivity}) {
    this.checker = checker ?? InternetConnection.createInstance();
    this.connectivity = connectivity ?? Connectivity();
  }

  Stream<InternetStatus> get onStatusChange => checker.onStatusChange;

  Stream<List<ConnectivityResult>> get onNetworkTypeChanged =>
      connectivity.onConnectivityChanged;

  factory SabianNetwork.instance() {
    return _instance ??= SabianNetwork._();
  }

  Future<bool> get isConnected async {
    bool isConnected = await checker.hasInternetAccess;
    return isConnected;
  }

  Future<SabianNetworkType> getCurrentType(
      {List<ConnectivityResult>? results}) async {
    final List<ConnectivityResult> connectivityResult =
        results ?? await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return SabianNetworkType.mobile;
    }
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return SabianNetworkType.wifi;
    }
    if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return SabianNetworkType.ethernet;
    }
    if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return SabianNetworkType.vpn;
    }
    if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return SabianNetworkType.bluetooth;
    }
    if (connectivityResult.contains(ConnectivityResult.other)) {
      if (Platform.isIOS || Platform.isMacOS) {
        return SabianNetworkType.vpn;
      }
      return SabianNetworkType.other;
    }
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return SabianNetworkType.none;
    }
    return SabianNetworkType.none;
  }
}

enum SabianNetworkType {
  // Wi-fi is available.
  // Note for Android:
  // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
  wifi,
  mobile,

  // Vpn connection active.
  // Note for iOS and macOS:
  // There is no separate network interface type for [vpn].
  // It returns [other] on any device (also simulator)
  vpn,
  ethernet,
  none,
  bluetooth,
  other,
}
