import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../../shared.dart';

enum CameraPermission {
  noCameraPermission, // Permission denied, but not forever
  noCameraPermissionPermanent, // Permission denied forever
  permisionApeect,
}

class PermissionConstants {
  const PermissionConstants._();

  static Future<CameraPermission> checkPermissionCamera() async {
    PermissionStatus result;

    result = await Permission.camera.status;
    Log.d(result);
    if (result.isGranted) {
      return CameraPermission.permisionApeect;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      return CameraPermission.noCameraPermissionPermanent;
    } else {
      return CameraPermission.noCameraPermission;
    }
  }

  static Future<void> requestPermissionWithOpenSettings() async {
    await openAppSettings();
  }

  static Future<void> requestPermission() async {
    await Permission.camera.request();
  }
}
