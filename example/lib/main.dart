import 'package:flutter/material.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// The uri of the sound whose play button was last tapped, if any.
  String? _playingUri;

  late final Future<List<Ringtone>> _ringtones =
      FlutterSystemRingtones.getRingtoneSounds();
  late final Future<List<Ringtone>> _alarms =
      FlutterSystemRingtones.getAlarmSounds();
  late final Future<List<Ringtone>> _notifications =
      FlutterSystemRingtones.getNotificationSounds();

  Future<void> _play(Ringtone ringtone) async {
    // play() auto-stops any currently playing sound.
    await FlutterSystemRingtones.play(ringtone);
    setState(() => _playingUri = ringtone.uri);
  }

  Future<void> _stop() async {
    await FlutterSystemRingtones.stop();
    setState(() => _playingUri = null);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('System Ringtones'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ringtones'),
              Tab(text: 'Alarms'),
              Tab(text: 'Notifications'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _SoundList(
              future: _ringtones,
              playingUri: _playingUri,
              onPlay: _play,
              onStop: _stop,
            ),
            _SoundList(
              future: _alarms,
              playingUri: _playingUri,
              onPlay: _play,
              onStop: _stop,
            ),
            _SoundList(
              future: _notifications,
              playingUri: _playingUri,
              onPlay: _play,
              onStop: _stop,
            ),
          ],
        ),
      ),
    );
  }
}

class _SoundList extends StatefulWidget {
  const _SoundList({
    Key? key,
    required this.future,
    required this.playingUri,
    required this.onPlay,
    required this.onStop,
  }) : super(key: key);

  final Future<List<Ringtone>> future;
  final String? playingUri;
  final ValueChanged<Ringtone> onPlay;
  final VoidCallback onStop;

  @override
  State<_SoundList> createState() => _SoundListState();
}

class _SoundListState extends State<_SoundList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Ringtone>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final sounds = snapshot.data!;
        if (sounds.isEmpty) {
          return const Center(child: Text('No sounds found'));
        }
        return ListView.builder(
          itemCount: sounds.length,
          itemBuilder: (context, index) {
            final sound = sounds[index];
            final isPlaying = sound.uri == widget.playingUri;
            return ListTile(
              title: Text(sound.title),
              subtitle: Text(
                sound.uri,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                onPressed: () =>
                    isPlaying ? widget.onStop() : widget.onPlay(sound),
              ),
            );
          },
        );
      },
    );
  }
}
