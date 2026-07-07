import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones_platform_interface.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones_method_channel.dart';

class MockFlutterSystemRingtonesPlatform
    implements FlutterSystemRingtonesPlatform {

  final List<String> log = [];

  @override
  Future<List<Ringtone>?> getRingtones() => Future.value([
    const Ringtone(id: '1', title: 'Ringtone 1', uri: 'uri1')
  ]);

  @override
  Future<List<Ringtone>?> getAlarms() => Future.value([
    const Ringtone(id: '2', title: 'Alarm 1', uri: 'uri2')
  ]);

  @override
  Future<List<Ringtone>?> getNotifications() => Future.value([
    const Ringtone(id: '3', title: 'Notification 1', uri: 'uri3')
  ]);

  @override
  Future<void> play(String uri) async {
    log.add('play:$uri');
  }

  @override
  Future<void> stop() async {
    log.add('stop');
  }
}

void main() {
  final FlutterSystemRingtonesPlatform initialPlatform = FlutterSystemRingtonesPlatform.instance;

  test('$MethodChannelFlutterSystemRingtones is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSystemRingtones>());
  });

  test('getRingtoneSounds', () async {
    MockFlutterSystemRingtonesPlatform fakePlatform = MockFlutterSystemRingtonesPlatform();
    FlutterSystemRingtonesPlatform.instance = fakePlatform;
  
    final result = await FlutterSystemRingtones.getRingtoneSounds();
    expect(result, isNotNull);
    expect(result.length, 1);
    expect(result.first.id, '1');
    expect(result.first.title, 'Ringtone 1');
  });

  test('getAlarmSounds', () async {
    MockFlutterSystemRingtonesPlatform fakePlatform = MockFlutterSystemRingtonesPlatform();
    FlutterSystemRingtonesPlatform.instance = fakePlatform;
  
    final result = await FlutterSystemRingtones.getAlarmSounds();
    expect(result, isNotNull);
    expect(result.length, 1);
    expect(result.first.id, '2');
    expect(result.first.title, 'Alarm 1');
  });

  test('getNotificationSounds', () async {
    MockFlutterSystemRingtonesPlatform fakePlatform = MockFlutterSystemRingtonesPlatform();
    FlutterSystemRingtonesPlatform.instance = fakePlatform;
  
    final result = await FlutterSystemRingtones.getNotificationSounds();
    expect(result, isNotNull);
    expect(result.length, 1);
    expect(result.first.id, '3');
    expect(result.first.title, 'Notification 1');
  });

  test('play forwards the ringtone uri to the platform', () async {
    MockFlutterSystemRingtonesPlatform fakePlatform = MockFlutterSystemRingtonesPlatform();
    FlutterSystemRingtonesPlatform.instance = fakePlatform;

    const ringtone = Ringtone(id: '1', title: 'Ringtone 1', uri: 'uri1');
    await FlutterSystemRingtones.play(ringtone);
    expect(fakePlatform.log, ['play:uri1']);
  });

  test('stop forwards to the platform', () async {
    MockFlutterSystemRingtonesPlatform fakePlatform = MockFlutterSystemRingtonesPlatform();
    FlutterSystemRingtonesPlatform.instance = fakePlatform;

    await FlutterSystemRingtones.stop();
    expect(fakePlatform.log, ['stop']);
  });
}
