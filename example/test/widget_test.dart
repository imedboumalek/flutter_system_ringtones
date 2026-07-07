import 'package:flutter_system_ringtones_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the three sound category tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Ringtones'), findsOneWidget);
    expect(find.text('Alarms'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
  });
}
