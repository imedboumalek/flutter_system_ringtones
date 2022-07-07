# flutter_system_ringtones

An Android & iOS plugin to retrieve a list of system ringtones using native API's

## Getting Started

Import the package

```dart
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
```

Get a list of available ringtones

```dart
await FlutterSystemRingtones.getRingtones();
```

Get a list of available alarm ringtones

```dart
await FlutterSystemRingtones.getAlarms();
```

Get a list of available notification ringtones

```dart
await FlutterSystemRingtones.getNotifications();
```

#TODO
[x] Android: Get a list of available ringtones dynamically
[] iOS: Get a list of available ringtones dynamically (Help Wanted)
[] Write tests
