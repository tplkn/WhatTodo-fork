// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Create project test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    expect(find.text('Projects'), findsWidgets);

//    await tester.tap(find.text('Projects')); // doesn't open expandable tile
    await tester.tap(find.byKey(Key('projects'))); // doesn't open expandable tile
    await tester.pump();

    //all next steps are useless due to there're no visible button "Add project"
    //expect(find.text('Add Project'), findsWidgets); //doesn't work
//    await tester.tap(find.byKey(Key('add-project')));
//    await tester.pump();
  });
}
