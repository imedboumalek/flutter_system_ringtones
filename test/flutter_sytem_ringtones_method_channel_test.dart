import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sytem_ringtones/flutter_sytem_ringtones_method_channel.dart';

void main() {
  MethodChannelFlutterSytemRingtones platform = MethodChannelFlutterSytemRingtones();
  const MethodChannel channel = MethodChannel('flutter_sytem_ringtones');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
