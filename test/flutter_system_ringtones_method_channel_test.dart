import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones_method_channel.dart';

void main() {
  MethodChannelFlutterSystemRingtones platform = MethodChannelFlutterSystemRingtones();
  const MethodChannel channel = MethodChannel('flutter_system_ringtones');

  TestWidgetsFlutterBinding.ensureInitialized();

  const mockRingtones = [
    {
      'id': '1',
      'title': 'Ringtone 1',
      'uri': 'content://media/internal/audio/media/1',
    }
  ];

  final List<MethodCall> log = [];

  setUp(() {
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      log.add(methodCall);
      switch (methodCall.method) {
        case 'getRingtones':
        case 'getAlarms':
        case 'getNotifications':
          return mockRingtones;
        case 'play':
        case 'stop':
          return null;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getRingtones', () async {
    final result = await platform.getRingtones();
    expect(result, isNotNull);
    expect(result!.length, 1);
    expect(result.first.id, '1');
    expect(result.first.title, 'Ringtone 1');
    expect(result.first.uri, 'content://media/internal/audio/media/1');
  });

  test('getAlarms', () async {
    final result = await platform.getAlarms();
    expect(result, isNotNull);
    expect(result!.length, 1);
    expect(result.first.id, '1');
  });

  test('getNotifications', () async {
    final result = await platform.getNotifications();
    expect(result, isNotNull);
    expect(result!.length, 1);
    expect(result.first.id, '1');
  });

  test('play sends the uri as an argument', () async {
    await platform.play('content://media/internal/audio/media/1');
    expect(log, hasLength(1));
    expect(log.first.method, 'play');
    expect(log.first.arguments, {'uri': 'content://media/internal/audio/media/1'});
  });

  test('stop sends no arguments', () async {
    await platform.stop();
    expect(log, hasLength(1));
    expect(log.first.method, 'stop');
    expect(log.first.arguments, isNull);
  });

  test('play rethrows PlatformException from the platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      throw PlatformException(code: 'PLAY_ERROR', message: 'boom');
    });

    expect(
      () => platform.play('bad://uri'),
      throwsA(isA<PlatformException>()
          .having((e) => e.code, 'code', 'PLAY_ERROR')),
    );
  });
}
