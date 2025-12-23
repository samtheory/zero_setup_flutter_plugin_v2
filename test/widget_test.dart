// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app_test_plugin/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home screen displays correctly', (WidgetTester tester) async {
    // Build our home screen and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify that the home screen displays the expected text
    expect(find.text('Welcome to the App!'), findsOneWidget);
    expect(find.text('This is the home screen of your Flutter app.'), findsOneWidget);

    // Verify that the app bar is present
    expect(find.text('Home'), findsOneWidget);

    // Verify that the floating action button is present
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
