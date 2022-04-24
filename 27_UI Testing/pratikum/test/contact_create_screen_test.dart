import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pratikum/screen/contact/contact_create_screen.dart';
import 'package:pratikum/screen/contact/contact_create_view_model.dart';
import 'package:pratikum/screen/contact/contact_detail_view_model.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:pratikum/screen/foods/foods_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Contact Create screen', (WidgetTester tester) async {
    Widget ctc = const ContactCreateScreen();
    await tester.pumpWidget(MaterialApp(
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
    ));

    expect(find.byWidget(ctc), findsOneWidget);
    expect(find.text("Create New Contact"), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('fullname')), 'jovinlidan');
    await tester.enterText(find.byKey(const ValueKey('phone')), '089512383532');

    expect(find.text("jovinlidan"), findsOneWidget);
    expect(find.text("089512383532"), findsOneWidget);
  });
}
