import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uiflutter/states/permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit() : super(PermissionsInitial());

  Future<void> requestPermissions() async {
    List<Permission> permissions = await _getPlatformPermissions();

    Map<Permission, PermissionStatus> statuses = await permissions.request();

    bool allGranted = statuses.values.every((status) => status.isGranted);
    bool anyPermanentlyDenied = statuses.values.any((status) =>
    status.isPermanentlyDenied);

    if (allGranted) {
      emit(PermissionsGranted());
    } else if (anyPermanentlyDenied) {
      await openAppSettings();
      emit(PermissionsPermanentlyDenied());
    } else {
      emit(PermissionsDenied());
    }
  }

  Future<void> checkInitialPermissions() async {
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
      emit(PermissionsGranted());
    } else if (isPermanentlyDenied) {
      emit(PermissionsPermanentlyDenied());
    } else {
      emit(PermissionsDenied());
    }
  }

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

  Future<List<Permission>> _getPlatformPermissions() async {
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
}
