import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_sytem_ringtones_method_channel.dart';

abstract class FlutterSytemRingtonesPlatform extends PlatformInterface {
  /// Constructs a FlutterSytemRingtonesPlatform.
  FlutterSytemRingtonesPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSytemRingtonesPlatform _instance = MethodChannelFlutterSytemRingtones();

  /// The default instance of [FlutterSytemRingtonesPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSytemRingtones].
  static FlutterSytemRingtonesPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSytemRingtonesPlatform] when
  /// they register themselves.
  static set instance(FlutterSytemRingtonesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
