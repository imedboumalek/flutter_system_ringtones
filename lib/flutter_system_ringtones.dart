// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter_system_ringtones/src/ringtone.dart';

import 'flutter_system_ringtones_platform_interface.dart';
export 'src/ringtone.dart';

class FlutterSystemRingtones {
  FlutterSystemRingtones._();

  static Future<List<Ringtone>> getRingtoneSounds() async {
    return await FlutterSystemRingtonesPlatform.instance.getRingtones() ?? [];
  }

  static Future<List<Ringtone>> getAlarmSounds() async {
    return await FlutterSystemRingtonesPlatform.instance.getAlarms() ?? [];
  }

  static Future<List<Ringtone>> getNotificationSounds() async {
    return await FlutterSystemRingtonesPlatform.instance.getNotifications() ?? [];
  }
}
