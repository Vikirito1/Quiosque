import 'package:permission_handler/permission_handler.dart';

class BluetoothPermissionHandler {
  static Future<bool> checkPermission() async {
    final PermissionStatus bluetoothConnectStatus =
        await Permission.bluetoothConnect.status;

    return bluetoothConnectStatus.isGranted;
  }

  static Future<PermissionStatus> requestBluetoothConnectPermission() async {
    final PermissionStatus requestResult =
        await Permission.bluetoothConnect.request();
    return requestResult;
  }
}
