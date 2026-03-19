import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<int> _getPlatformSdk() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String osVersion;

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    osVersion = iosInfo.systemVersion;
    return int.tryParse(osVersion.split('.').first) ?? 0;
  }
}

Future<List<Permission>> getPlatformPermissions() async {
  int platformSdk = await _getPlatformSdk();
  if (Platform.isAndroid) {
    if (platformSdk >= 31) {
      return [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ];
    } else {
      return [
        Permission.bluetooth,
        Permission.location
      ];
    }
  } else {
    return [Permission.bluetooth];
  }
}

Future<void> checkInitialPermissions({
  required Function onAllGranted,
  required Function onPermanentlyDenied,
  required Function onOtherCases
}) async {
  bool allGranted = false;
  bool isPermanentlyDenied = false;
  int platformSdk = await _getPlatformSdk();

  if (Platform.isAndroid) {
    if (platformSdk >= 31) {
      var scan = await Permission.bluetoothScan.status;
      var connect = await Permission.bluetoothConnect.status;

      allGranted = scan.isGranted && connect.isGranted;
      isPermanentlyDenied = scan.isPermanentlyDenied || connect.isPermanentlyDenied;

    } else {
      var bluetooth = await Permission.bluetooth.status;
      var loc = await Permission.location.status;

      allGranted = bluetooth.isGranted && loc.isGranted;
      isPermanentlyDenied = bluetooth.isPermanentlyDenied || loc.isPermanentlyDenied;
    }
  } else if (Platform.isIOS) {
    var bluetooth = await Permission.bluetooth.status;

    allGranted = bluetooth.isGranted;
    isPermanentlyDenied = bluetooth.isPermanentlyDenied;
  }

  if (allGranted) {
    onAllGranted();
  } else if (isPermanentlyDenied) {
    onPermanentlyDenied();
  } else {
    onOtherCases();
  }
}

Future<void> requestPermissions({
  required Function onAllGranted,
  required Function onPermanentlyDenied,
  required Function onOtherCases
}) async {
  List<Permission> permissions = await getPlatformPermissions();

  Map<Permission, PermissionStatus> statuses = await permissions.request();

  bool allGranted = statuses.values.every((status) => status.isGranted);
  bool anyPermanentlyDenied = statuses.values.any((status) => status.isPermanentlyDenied);

  if (allGranted) {
    onAllGranted();
  } else if (anyPermanentlyDenied) {
    await openAppSettings();
    onPermanentlyDenied();
  } else {
    onOtherCases();
  }
}