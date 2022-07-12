import 'dart:convert';

class SystemSound {
  final String id;
  final String title;
  // final Uint8List data;
  final String uri;

  SystemSound({
    required this.id,
    required this.title,
    // required this.data,
    required this.uri,
  });

  factory SystemSound.fromJson(Map<String, dynamic> map) => SystemSound(
        id: map['id'] as String,
        title: map['title'] as String,
        // data: Uint8List.fromList(map['data']),
        uri: map['uri'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        // 'data': data,
        'uri': uri,
      };

  factory SystemSound.fromEncodedJson(String encodedJson) =>
      SystemSound.fromJson(json.decode(encodedJson));
  String toEncodedJson() => json.encode(toJson());
  @override
  String toString() {
    return 'Ringtone{id: $id, title: $title, uri: $uri}';
  }
}
