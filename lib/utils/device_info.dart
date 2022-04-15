
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo{
   Future<int?> currentDeviceSDK() async {
     DeviceInfoPlugin di = DeviceInfoPlugin();
     AndroidDeviceInfo androidInfo = await di.androidInfo;
     return androidInfo.version.sdkInt;
     }
}