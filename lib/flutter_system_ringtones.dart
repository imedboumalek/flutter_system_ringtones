// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter_system_ringtones/src/ringtone.dart';

import 'src/flutter_system_ringtones_platform_interface.dart';
export 'src/ringtone.dart';

class FlutterSystemRingtones {
  Future<List<Ringtone>?> getRingtones() {
    return FlutterSystemRingtonesPlatform.instance.getRingtones();
  }

  Future<List<Ringtone>?> getAlarms() {
    return FlutterSystemRingtonesPlatform.instance.getAlarms();
  }

  Future<List<Ringtone>?> getNotifications() {
    return FlutterSystemRingtonesPlatform.instance.getNotifications();
  }
}
