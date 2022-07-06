import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_system_ringtones/src/ringtone.dart';

import 'flutter_system_ringtones_platform_interface.dart';

/// An implementation of [FlutterSystemRingtonesPlatform] that uses method channels.
class MethodChannelFlutterSystemRingtones extends FlutterSystemRingtonesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_system_ringtones');

  @override
  Future<List<Ringtone>?> getRingtones() async {
    final version = await methodChannel.invokeMethod<List<Map<String, dynamic>>>('getRingtones');
    return version?.map((map) => Ringtone.fromMap(map)).toList();
  }
}
