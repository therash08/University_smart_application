import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:university_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // MyApp() এর বদলে UniversitySmartApp() দিন
    await tester.pumpWidget(const UniversitySmartApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
