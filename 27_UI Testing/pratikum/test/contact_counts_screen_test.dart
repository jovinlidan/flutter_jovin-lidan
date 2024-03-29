import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pratikum/screen/contact/contact_counts_screen.dart';
import 'package:pratikum/screen/contact/contact_create_view_model.dart';
import 'package:pratikum/screen/contact/contact_detail_view_model.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:pratikum/screen/foods/foods_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Contact Counts screen', (WidgetTester tester) async {
    Widget ctc = const ContactCountsScreen();
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
    expect(find.text("Contact Counts"), findsOneWidget);
    expect(find.text("1"), findsOneWidget);
  });
}
