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
    return await FlutterSystemRingtonesPlatform.instance.getNotifications() ??
        [];
  }

  /// Plays [ringtone] using the platform's native audio facilities.
  ///
  /// Any currently playing sound is stopped first. Throws a
  /// `PlatformException` if the sound cannot be resolved or played.
  static Future<void> play(Ringtone ringtone) {
    return FlutterSystemRingtonesPlatform.instance.play(ringtone.uri);
  }

  /// Stops the currently playing sound, if any. Safe to call when idle.
  static Future<void> stop() {
    return FlutterSystemRingtonesPlatform.instance.stop();
  }
}
