import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_sytem_ringtones_platform_interface.dart';

/// An implementation of [FlutterSytemRingtonesPlatform] that uses method channels.
class MethodChannelFlutterSytemRingtones extends FlutterSytemRingtonesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_sytem_ringtones');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
