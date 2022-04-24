import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pratikum/screen/contact/contact_create_view_model.dart';
import 'package:pratikum/screen/contact/contact_detail_view_model.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:pratikum/screen/foods/foods_screen.dart';
import 'package:pratikum/screen/foods/foods_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Foods screen', (WidgetTester tester) async {
    Widget fd = const FoodsScreen();
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
            child: fd,
          ),
        ),
        const Duration(seconds: 10));
    expect(find.byWidget(fd), findsOneWidget);
    expect(find.text("Foods"), findsOneWidget);

    expect(find.byWidgetPredicate((widget) => widget is Scaffold), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is AppBar), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Consumer), findsOneWidget);

    await tester.dragFrom(tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
    await tester.pumpAndSettle();

    expect(find.text("Foods"), findsWidgets);
    expect(find.text("Contacts"), findsOneWidget);

    expect(find.byWidgetPredicate((widget) => widget is ListView), findsOneWidget);
  });
}
