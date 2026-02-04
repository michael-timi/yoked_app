// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:yoked_app/main.dart';

void main() {
  testWidgets('App boots to Start screen after splash', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Splash: 400ms + flip 300ms + 600ms then navigates to Start.
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });
}
