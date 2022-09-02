import 'dart:convert';

import 'package:equatable/equatable.dart';

class Ringtone extends Equatable {
  final String id;
  final String title;
  // final Uint8List data;
  final String uri;

  const Ringtone({
    required this.id,
    required this.title,
    // required this.data,
    required this.uri,
  });

  factory Ringtone.fromJson(Map<String, dynamic> map) => Ringtone(
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

  factory Ringtone.fromEncodedJson(String encodedJson) =>
      Ringtone.fromJson(json.decode(encodedJson));
  String toEncodedJson() => json.encode(toJson());
  @override
  String toString() {
    return 'Ringtone{id: $id, title: $title, uri: $uri}';
  }

  @override
  List<Object?> get props => [id, title, uri];

  Ringtone copyWith({
    String? id,
    String? title,
    // Uint8List? data,
    String? uri,
  }) {
    return Ringtone(
      id: id ?? this.id,
      title: title ?? this.title,
      // data: data ?? this.data,
      uri: uri ?? this.uri,
    );
  }
}
