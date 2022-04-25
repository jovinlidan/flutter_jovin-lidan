import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pratikum/screen/contact/contact_create_view_model.dart';
import 'package:pratikum/screen/contact/contact_detail_screen.dart';
import 'package:pratikum/screen/contact/contact_detail_view_model.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:pratikum/screen/foods/foods_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Contact detail screen', (WidgetTester tester) async {
    Widget ctc = const ContactDetailScreen();
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
    expect(find.text("1"), findsOneWidget);

    //Testing data
    expect(find.text("Jovin"), findsOneWidget);
    expect(find.text("0895414368368"), findsOneWidget);
    expect(find.text("0895414368367"), findsNothing);
  });
}
