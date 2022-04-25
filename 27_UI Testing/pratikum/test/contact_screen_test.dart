// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pratikum/screen/contact/contact_create_view_model.dart';
import 'package:pratikum/screen/contact/contact_detail_view_model.dart';
import 'package:pratikum/screen/contact/contacts_screen.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:pratikum/screen/foods/foods_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Contact screen', (WidgetTester tester) async {
    Widget ctc = const ContactsScreen();
    await tester.pumpFrames(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ContactsViewModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => ContactCreateViewModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => ContactDetailViewModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => FoodsViewModel(),
              )
            ],
            child: ctc,
          ),
        ),
        const Duration(seconds: 10));

    expect(find.byWidget(ctc), findsOneWidget);
    expect(find.text("Contacts"), findsOneWidget);
    expect(find.text("Create New Contact"), findsOneWidget);

    //Testing data
    expect(find.text("Jovin"), findsOneWidget);
    expect(find.text("0895414368368"), findsOneWidget);
    expect(find.text("0895414368367"), findsNothing);

    expect(find.byKey(const ValueKey('ContactKey')), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is InkWell), findsWidgets);
    expect(find.byWidgetPredicate((widget) => widget is Consumer), findsWidgets);

    await tester.dragFrom(tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
    await tester.pumpAndSettle();

    expect(find.text("Foods"), findsOneWidget);
    expect(find.text("Contacts"), findsWidgets);
  });
}
