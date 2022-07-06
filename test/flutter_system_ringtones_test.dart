// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
// import 'package:flutter_system_ringtones/flutter_system_ringtones_platform_interface.dart';
// import 'package:flutter_system_ringtones/flutter_system_ringtones_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockFlutterSystemRingtonesPlatform 
//     with MockPlatformInterfaceMixin
//     implements FlutterSystemRingtonesPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final FlutterSystemRingtonesPlatform initialPlatform = FlutterSystemRingtonesPlatform.instance;

//   test('$MethodChannelFlutterSystemRingtones is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFlutterSystemRingtones>());
//   });

//   test('getPlatformVersion', () async {
//     FlutterSystemRingtones flutterSystemRingtonesPlugin = FlutterSystemRingtones();
//     MockFlutterSystemRingtonesPlatform fakePlatform = MockFlutterSystemRingtonesPlatform();
//     FlutterSystemRingtonesPlatform.instance = fakePlatform;
  
//     expect(await flutterSystemRingtonesPlugin.getPlatformVersion(), '42');
//   });
// }
