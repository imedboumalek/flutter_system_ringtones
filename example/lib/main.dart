import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterSystemRingtonesPlugin = FlutterSystemRingtones();
  List<Ringtone> ringtones = [];

  @override
  void initState() {
    super.initState();
    getRingtones();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getRingtones() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final temp = await _flutterSystemRingtonesPlugin.getRingtones() ?? [];
      setState(() {
        ringtones = temp;
      });
    } on PlatformException {
      print('Failed to get platform version.');
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: ringtones.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(ringtones[index].title),
                subtitle: Text(ringtones[index].uri),
                onTap: () {
                  // _flutterSystemRingtonesPlugin.playRingtone(ringtones[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
