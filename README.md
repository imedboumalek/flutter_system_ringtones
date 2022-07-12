# flutter_system_ringtones

An Android & iOS (WIP) plugin to dynamically retrieve a list of system sounds using native API's

## Getting Started

Import the package

```dart
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
```

Get a list of available sounds

```dart
await FlutterSystemRingtones.getRingtoneSounds();
```

Get a list of available alarm sounds

```dart
await FlutterSystemRingtones.getAlarmSounds();
```

Get a list of available notification sounds

```dart
await FlutterSystemRingtones.getNotificationSounds();
```

### TODO

- [x] Android: Get a list of available ringtones dynamically

- [ ] iOS: Get a list of available ringtones dynamically (Help Needed)

- [ ] Write tests
