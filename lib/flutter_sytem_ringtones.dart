
import 'flutter_sytem_ringtones_platform_interface.dart';

class FlutterSytemRingtones {
  Future<String?> getPlatformVersion() {
    return FlutterSytemRingtonesPlatform.instance.getPlatformVersion();
  }
}
