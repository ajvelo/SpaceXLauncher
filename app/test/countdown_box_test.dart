import 'package:SpaceX_Launcher/widgets/countdown_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      "Countdown boxes have a unit and corresponding timeRemaining text",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: CountDownBox(
      text: "DAYS",
      timeRemaining: "30",
    ))));

    final unitText = find.text("DAYS");
    final timeRemainingFind = find.text("30");

    expect(unitText, findsOneWidget);
    expect(timeRemainingFind, findsOneWidget);
  });
}
