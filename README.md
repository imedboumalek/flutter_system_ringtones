# flutter_system_ringtones

A Flutter plugin to list and preview system ringtones, alarms and notification sounds on Android and iOS.

## Getting Started

Import the package

```dart
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
```

Get a list of available sounds

```dart
final ringtones = await FlutterSystemRingtones.getRingtoneSounds();
final alarms = await FlutterSystemRingtones.getAlarmSounds();
final notifications = await FlutterSystemRingtones.getNotificationSounds();
```

Each `Ringtone` has an `id`, a human-readable `title` and a platform-specific `uri` (see below).

## Previewing sounds

```dart
// Plays the sound natively (Android: RingtoneManager, iOS: AVAudioPlayer).
// Any currently playing sound is stopped first.
await FlutterSystemRingtones.play(ringtone);

// Stops the currently playing sound, if any. Safe to call when idle.
await FlutterSystemRingtones.stop();
```

`play` throws a `PlatformException` (code `INVALID_ARGUMENT` or `PLAY_ERROR`) if the sound cannot be resolved or played.

Notes:

- Only one sound plays at a time; there is no completion callback yet, so track "what did I start" in your own state (see the example app).
- **Android**: playback uses the ringtone audio stream — if the device's ringer volume is muted the preview is silent.
- **iOS**: the plugin sets the shared `AVAudioSession` category to `.playback` so previews are audible even when the silent switch is on. This may pause or duck other audio playing in your app.

## Understanding the `uri` field

### Android

`uri` is a `content://` media URI (e.g. `content://media/internal/audio/media/42`) as provided by [`RingtoneManager`](https://developer.android.com/reference/android/media/RingtoneManager). You can use it with:

- This plugin's `play`/`stop` for previews.
- `RingtoneManager.getRingtone(context, uri)` or `MediaPlayer`/`ExoPlayer` in native code.
- Dart audio packages that accept content URIs.

Setting a sound as the device ringtone (writing `Settings.System`) requires the `WRITE_SETTINGS` special permission and is outside the scope of this plugin.

### iOS

`uri` is a `file://` URL pointing into `/System/Library/Audio/UISounds/` (e.g. `file:///System/Library/Audio/UISounds/Anticipate.caf`). These are read-only system files. You can use the URL with this plugin's `play`/`stop`, with `AVAudioPlayer` in native code, or with any Dart audio package that accepts file paths (`Uri.parse(uri).toFilePath()`).

There is no public API to set a system ringtone on iOS.

### iOS behavior details

iOS has no public equivalent to Android's `RingtoneManager`. The implementation enumerates `.caf`/`.m4r`/`.aiff`/`.wav` files from `/System/Library/Audio/UISounds/`, which is readable by sandboxed apps. Because iOS does not categorise sounds into ringtone/alarm/notification types, the three methods return overlapping sets:

| Method | Source |
|---|---|
| `getRingtoneSounds()` | `/System/Library/Audio/UISounds/` (top-level) |
| `getAlarmSounds()` | All sounds (recursive), filtered to alarm/timer/bell-style keywords; falls back to the full list if nothing matches |
| `getNotificationSounds()` | Top-level + `nano/` subdirectory |

`/System/Library/Audio/UISounds/` is an undocumented path, so treat the iOS listing as best effort — its contents can change between iOS versions.

## Supported platforms

- **Android**: minSdk 21
- **iOS**: 12.0+
