import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const ringtone = Ringtone(id: '1', title: 'Chime', uri: 'uri1');

  test('instances with the same fields are equal', () {
    expect(ringtone, const Ringtone(id: '1', title: 'Chime', uri: 'uri1'));
    expect(
      ringtone.hashCode,
      const Ringtone(id: '1', title: 'Chime', uri: 'uri1').hashCode,
    );
  });

  test('instances differing in any field are not equal', () {
    expect(ringtone, isNot(ringtone.copyWith(id: '2')));
    expect(ringtone, isNot(ringtone.copyWith(title: 'Bell')));
    expect(ringtone, isNot(ringtone.copyWith(uri: 'uri2')));
  });

  test('copyWith without arguments returns an equal instance', () {
    expect(ringtone.copyWith(), ringtone);
  });

  test('json round-trips', () {
    expect(Ringtone.fromJson(ringtone.toJson()), ringtone);
    expect(Ringtone.fromEncodedJson(ringtone.toEncodedJson()), ringtone);
  });
}
