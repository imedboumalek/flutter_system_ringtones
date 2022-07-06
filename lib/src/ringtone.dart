// import 'dart:typed_data';

class Ringtone {
  final String id;
  final String title;
  // final Uint8List data;
  final String uri;

  Ringtone({
    required this.id,
    required this.title,
    // required this.data,
    required this.uri,
  });

  factory Ringtone.fromMap(Map<String, dynamic> map) => Ringtone(
        id: map['id'] as String,
        title: map['title'] as String,
        // data: Uint8List.fromList(map['data']),
        uri: map['uri'] as String,
      );
  @override
  String toString() {
    return 'Ringtone{id: $id, title: $title, uri: $uri}';
  }
}
