// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:classwork/main.dart';

void main() {
  testWidgets('sign in opens the multi-screen demo shell', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);

    await tester.tap(find.text('Log In'));
    await tester.pump();

    expect(find.text('Instagram'), findsNWidgets(2));
    expect(find.text('s.bhandari__'), findsNothing);

    await tester.tap(find.byTooltip('Open profile'));
    await tester.pump();
    expect(find.text('Sharad Bhandari'), findsOneWidget);

    await tester.tap(find.text('Spotify'));
    await tester.pump();
    expect(find.text('Good evening'), findsOneWidget);

    await tester.tap(find.text('Card'));
    await tester.pump();
    expect(find.text('Simple and easy to use app.'), findsOneWidget);
  });
}
