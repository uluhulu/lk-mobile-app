import 'package:mkk/services/platform.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool?> checkPermission() async {
    if (isAndroid()) {
      Map<Permission, PermissionStatus> statues =
          await [Permission.camera, Permission.photos].request();
      PermissionStatus? statusCamera = statues[Permission.camera];

      PermissionStatus? statusPhotos = statues[Permission.photos];
      bool isGranted = statusCamera == PermissionStatus.granted &&
          statusPhotos == PermissionStatus.granted;
      if (isGranted) {
        return true;
      }
      bool isPermanentlyDenied =
          statusCamera == PermissionStatus.permanentlyDenied ||
              statusPhotos == PermissionStatus.permanentlyDenied;
      if (isPermanentlyDenied) {
        return false;
      }
    } else {
      Map<Permission, PermissionStatus> statues = await [
        Permission.camera,
        Permission.storage,
        Permission.photos
      ].request();
      PermissionStatus? statusCamera = statues[Permission.camera];
      PermissionStatus? statusStorage = statues[Permission.storage];
      PermissionStatus? statusPhotos = statues[Permission.photos];
      bool isGranted = statusCamera == PermissionStatus.granted &&
          statusStorage == PermissionStatus.granted &&
          statusPhotos == PermissionStatus.granted;
      if (isGranted) {
        return true;
      }
      bool isPermanentlyDenied =
          statusCamera == PermissionStatus.permanentlyDenied ||
              statusStorage == PermissionStatus.permanentlyDenied ||
              statusPhotos == PermissionStatus.permanentlyDenied;
      if (isPermanentlyDenied) {
        return false;
      }
    }
    return null;
  }
}
