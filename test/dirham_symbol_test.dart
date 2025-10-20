import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:dirham_symbol/dirham_symbol.dart';

void main() {
  testWidgets('DirhamIcon renders with default size',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DirhamIcon(),
        ),
      ),
    );

    // Verify the widget exists
    expect(find.byType(DirhamIcon), findsOneWidget);
  });

  testWidgets('DirhamIcon renders with custom size',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DirhamIcon(size: 50),
        ),
      ),
    );

    expect(find.byType(DirhamIcon), findsOneWidget);
  });

  testWidgets('DirhamIcon renders with custom color',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DirhamIcon(size: 30, color: Colors.green),
        ),
      ),
    );

    expect(find.byType(DirhamIcon), findsOneWidget);
  });
}
