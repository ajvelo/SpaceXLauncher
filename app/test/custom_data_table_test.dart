import 'package:SpaceX_Launcher/widgets/custom_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_launch_model.dart';

void main() {
  testWidgets("Rows have a favorite button, title and date",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: CustomDataTable(
          context: null,
          launches: MockLaunchModel.allLaunches(),
          notifyParent: null),
    )));

    final favoriteIconFind = find.byIcon(Icons.favorite_border);
    final titleFind = find.text(MockLaunchModel.mockLaunchModel.name);
    final dateFind = find.text(MockLaunchModel.mockLaunchModel.formattedDate);

    expect(favoriteIconFind, findsWidgets);
    expect(titleFind, findsOneWidget);
    expect(dateFind, findsOneWidget);
  });
}
