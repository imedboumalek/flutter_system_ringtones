import 'dart:convert';

class Ringtone {
  final String id;
  final String title;
  final String uri;

  const Ringtone({
    required this.id,
    required this.title,
    required this.uri,
  });

  factory Ringtone.fromJson(Map<String, dynamic> map) => Ringtone(
        id: map['id'] as String,
        title: map['title'] as String,
        uri: map['uri'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'uri': uri,
      };

  factory Ringtone.fromEncodedJson(String encodedJson) =>
      Ringtone.fromJson(json.decode(encodedJson));
  String toEncodedJson() => json.encode(toJson());

  @override
  String toString() {
    return 'Ringtone{id: $id, title: $title, uri: $uri}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ringtone &&
          other.id == id &&
          other.title == title &&
          other.uri == uri;

  @override
  int get hashCode => Object.hash(id, title, uri);

  Ringtone copyWith({
    String? id,
    String? title,
    String? uri,
  }) {
    return Ringtone(
      id: id ?? this.id,
      title: title ?? this.title,
      uri: uri ?? this.uri,
    );
  }
}
