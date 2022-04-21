import 'package:flutter/material.dart';
import 'package:pratikum/screen/contact/contact_counts_screen.dart';
import 'package:pratikum/screen/contact/contact_create_screen.dart';
import 'package:pratikum/screen/contact/contact_create_view_model.dart';
import 'package:pratikum/screen/contact/contact_detail_screen.dart';
import 'package:pratikum/screen/contact/contact_detail_view_model.dart';
import 'package:pratikum/screen/contact/contacts_screen.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContactsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactCreateViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactDetailViewModel(),
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const ContactsScreen(),
          '/contact-create': (context) => const ContactCreateScreen(),
          '/contact-detail': (context) => const ContactDetailScreen(),
          '/contact-counts': (context) => const ContactCountsScreen()
        },
      ),
    ),
  );
}