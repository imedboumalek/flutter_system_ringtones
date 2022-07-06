import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_system_ringtones_method_channel.dart';

abstract class FlutterSystemRingtonesPlatform extends PlatformInterface {
  /// Constructs a FlutterSystemRingtonesPlatform.
  FlutterSystemRingtonesPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSystemRingtonesPlatform _instance = MethodChannelFlutterSystemRingtones();

  /// The default instance of [FlutterSystemRingtonesPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSystemRingtones].
  static FlutterSystemRingtonesPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSystemRingtonesPlatform] when
  /// they register themselves.
  static set instance(FlutterSystemRingtonesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
