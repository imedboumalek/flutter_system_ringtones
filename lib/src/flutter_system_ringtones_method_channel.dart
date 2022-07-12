import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_system_ringtones/src/ringtone.dart';

import 'flutter_system_ringtones_platform_interface.dart';

/// An implementation of [FlutterSystemRingtonesPlatform] that uses method channels.
class MethodChannelFlutterSystemRingtones extends FlutterSystemRingtonesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_system_ringtones');

  /// invokes the getRingtones method on the native platform, which returns a list of hashmaps that
  /// get converted to [Ringtone] objects containing platform ringtone sounds.
  @override
  Future<List<Ringtone>?> getRingtones() async {
    var ringtones = await methodChannel.invokeMethod<List>('getRingtones');
    ringtones = ringtones?.map((ringtone) => Map<String, dynamic>.from(ringtone)).toList();
    return ringtones?.map((map) => Ringtone.fromMap(map)).toList();
  }

  /// invokes the getAlarms method on the native platform, which returns a list of hashmaps that
  /// get converted to [Ringtone] objects containing platform alarm sounds.
  @override
  Future<List<Ringtone>?> getAlarms() async {
    var alarms = await methodChannel.invokeMethod<List>('getAlarms');
    alarms = alarms?.map((alarm) => Map<String, dynamic>.from(alarm)).toList();
    return alarms?.map((map) => Ringtone.fromMap(map)).toList();
  }

  /// invokes the getNotifications method on the native platform, which returns a list of hashmaps that
  /// get converted to [Ringtone] objects containing platform notification sounds.
  @override
  Future<List<Ringtone>?> getNotifications() async {
    var notifications = await methodChannel.invokeMethod<List>('getNotifications');
    notifications =
        notifications?.map((notification) => Map<String, dynamic>.from(notification)).toList();
    return notifications?.map((map) => Ringtone.fromMap(map)).toList();
  }
}
