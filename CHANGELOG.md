## 1.1.1

- Package metadata: added pub.dev topics; homepage and issue tracker now point at the GitHub repository.

## 1.1.0

- **Changed**: the plugin now has **zero runtime dependencies** — `equatable` and `plugin_platform_interface` were removed.
- `Ringtone` implements `==`/`hashCode` directly; equality semantics are unchanged (all three fields).
- `FlutterSystemRingtonesPlatform` is now a plain abstract class with a settable `instance`. If you implemented it in tests, drop the `MockPlatformInterfaceMixin` mixin — just `implements` the class.

## 1.0.0

- **Added**: `play(Ringtone)` and `stop()` for previewing sounds natively (Android `RingtoneManager`, iOS `AVAudioPlayer`). `play` auto-stops the previously playing sound.
- **Added**: iOS support is no longer work-in-progress — sounds are enumerated from `/System/Library/Audio/UISounds/` (including `.wav` files) and the plugin supports both Swift Package Manager and CocoaPods.
- **Fixed**: Android no longer crashes when a sound list is empty; ringtone URIs are now built with the documented `RingtoneManager.getRingtoneUri` API.
- **Changed**: Android sound lists load lazily on first request, off the main thread (previously loaded eagerly at engine startup).
- **Fixed**: iOS podspec metadata and platform version; removed the dead Objective-C shim and debug logging.
- **Fixed**: sound listing on the iOS simulator (system sounds are resolved via `SIMULATOR_ROOT`; previously all lists were empty on simulators).
- **Changed**: minimum Flutter version is now 3.24.0 (Dart SDK ^3.4.0).
- **Docs**: new README sections on previewing sounds and on what the `uri` field means per platform.

## 0.0.6

- Added Equatable and copyWith

## 0.0.5

- reverted "Updated `Ringtone` to `SystemSound`"

## 0.0.4

- update `fromMap` to `fromJson`
- update `toMap` to `toJson`
- Added encoding/decoding for fromJson/toJson methods.
- Updated `Ringtone` to `SystemSound`

## 0.0.3

- Methods now return an empty array if no results are found.
- Plugin methods are now static access only.
- Methods have a more descriptive name.

## 0.0.2

updated README.md

## 0.0.1

-get available systems sounds on Android
