import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getRingtoneSounds returns sounds', (tester) async {
    final sounds = await FlutterSystemRingtones.getRingtoneSounds();
    expect(sounds, isNotEmpty);
    expect(sounds.first.uri, isNotEmpty);
  });

  testWidgets('getAlarmSounds returns sounds', (tester) async {
    final sounds = await FlutterSystemRingtones.getAlarmSounds();
    expect(sounds, isNotEmpty);
  });

  testWidgets('getNotificationSounds returns sounds', (tester) async {
    final sounds = await FlutterSystemRingtones.getNotificationSounds();
    expect(sounds, isNotEmpty);
  });

  testWidgets('play and stop complete without errors', (tester) async {
    final sounds = await FlutterSystemRingtones.getRingtoneSounds();
    expect(sounds, isNotEmpty);

    await FlutterSystemRingtones.play(sounds.first);
    // Let it play briefly, then switch sounds to exercise auto-stop.
    await Future<void>.delayed(const Duration(seconds: 1));
    if (sounds.length > 1) {
      await FlutterSystemRingtones.play(sounds[1]);
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    await FlutterSystemRingtones.stop();
    // stop() is safe to call when idle.
    await FlutterSystemRingtones.stop();
  });
}
