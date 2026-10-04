// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:classwork/main.dart';

void main() {
  testWidgets('profile screen renders and toggles follow state', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('s.bhandari__'), findsOneWidget);
    expect(find.text('Sharad Bhandari'), findsOneWidget);
    expect(find.text('Follow'), findsOneWidget);

    await tester.tap(find.text('Follow'));
    await tester.pump();

    expect(find.text('Following'), findsOneWidget);
  });
}
