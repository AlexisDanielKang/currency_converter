import 'package:convert_money/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets("Renders screen correctly.", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text("Currency converter"), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Convert"), findsOneWidget);
  });

  testWidgets("Displays an error for an invalid value.", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.enterText(find.byType(TextField), "abc");
    await tester.tap(find.text("Convert"));

    await tester.pump();

    expect(find.textContaining("Error"), findsOneWidget);
  });

  testWidgets("Performs conversion and displays result.", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.enterText(find.byType(TextField), "10");
    await tester.tap(find.text("Convert"));

    await tester.pumpAndSettle();

    expect(find.textContaining("Result"), findsOneWidget);
  });

}