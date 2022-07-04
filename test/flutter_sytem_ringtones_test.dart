import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sytem_ringtones/flutter_sytem_ringtones.dart';
import 'package:flutter_sytem_ringtones/flutter_sytem_ringtones_platform_interface.dart';
import 'package:flutter_sytem_ringtones/flutter_sytem_ringtones_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSytemRingtonesPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterSytemRingtonesPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSytemRingtonesPlatform initialPlatform = FlutterSytemRingtonesPlatform.instance;

  test('$MethodChannelFlutterSytemRingtones is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSytemRingtones>());
  });

  test('getPlatformVersion', () async {
    FlutterSytemRingtones flutterSytemRingtonesPlugin = FlutterSytemRingtones();
    MockFlutterSytemRingtonesPlatform fakePlatform = MockFlutterSytemRingtonesPlatform();
    FlutterSytemRingtonesPlatform.instance = fakePlatform;
  
    expect(await flutterSytemRingtonesPlugin.getPlatformVersion(), '42');
  });
}
