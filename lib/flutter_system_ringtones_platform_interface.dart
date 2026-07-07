import 'package:flutter_system_ringtones/src/ringtone.dart';

import 'flutter_system_ringtones_method_channel.dart';

/// The interface that platform-specific implementations of
/// flutter_system_ringtones must implement.
abstract class FlutterSystemRingtonesPlatform {
  /// The instance of [FlutterSystemRingtonesPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSystemRingtones]. Platform-specific
  /// implementations (or tests) can replace it by setting this.
  static FlutterSystemRingtonesPlatform instance =
      MethodChannelFlutterSystemRingtones();

  Future<List<Ringtone>?> getRingtones() {
    throw UnimplementedError('getRingtones() has not been implemented.');
  }

  Future<List<Ringtone>?> getAlarms() {
    throw UnimplementedError('getAlarms() has not been implemented.');
  }

  Future<List<Ringtone>?> getNotifications() {
    throw UnimplementedError('getNotifications() has not been implemented.');
  }

  Future<void> play(String uri) {
    throw UnimplementedError('play() has not been implemented.');
  }

  Future<void> stop() {
    throw UnimplementedError('stop() has not been implemented.');
  }
}
