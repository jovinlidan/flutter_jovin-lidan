import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pratikum/bloc/contact_bloc.dart';
import 'package:pratikum/bloc/history_bloc.dart';
import 'package:pratikum/history_screen.dart';
import 'package:pratikum/new_contact_screen.dart';

class Person {
  String name;
  String phone;
  File? file;
  RadioOption gender;
  List<String> languages;
  String kelas;
  DateTime date;

  Person(
      {required this.name,
      required this.phone,
      this.file,
      required this.gender,
      required this.languages,
      required this.kelas,
      required this.date});
}

class Soal2 extends StatelessWidget {
  const Soal2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const CustomBody(),
        // NewContactScreen.newContactScreenName: (context) => const NewContactScreen(),
        HistoryScreen.historyScreenName: (context) => const HistoryScreen()
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == NewContactScreen.newContactScreenName) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const NewContactScreen(),
            transitionsBuilder: (_, animation, __, child) {
              final tween = Tween(begin: const Offset(1, 1), end: Offset.zero);
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        }
        return null;
      },
    );
  }
}

class CustomCard extends StatelessWidget {
  final Person person;
  final Function() onDelete;
  final Function() onUpdate;
  const CustomCard({Key? key, required this.person, required this.onDelete, required this.onUpdate})
      : super(key: key);

  void handleOpenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Contact Details"),
        content: Container(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [const Expanded(child: Text("Name")), Text(person.name)]),
              const SizedBox(height: 20),
              Row(children: [const Expanded(child: Text("Phone")), Text(person.phone)]),
              const SizedBox(height: 20),
              Row(children: [const Expanded(child: Text("Gender")), Text(person.gender.name)]),
              const SizedBox(height: 20),
              Row(children: [const Expanded(child: Text("Kelas")), Text(person.kelas)]),
              const SizedBox(height: 20),
              Row(children: [
                const Expanded(child: Text("Tanggal Lahir")),
                Text(DateFormat('dd/MM/yyyy').format(person.date))
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Text("Languages")),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: person.languages.isNotEmpty
                        ? person.languages.map((e) => Text(e)).toList()
                        : [const Text('-')],
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onDelete();
                },
                child: const Text("Delete Item", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onUpdate();
                },
                child: const Text("Update Item"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void handleCall(BuildContext context) {
    HistoryCall history = HistoryCall(person: person, timestamp: DateTime.now());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Calling ${person.name}")));
    BlocProvider.of<HistoryBloc>(context).add(AddHistory(history));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      leading: CircleAvatar(
        backgroundImage: person.file != null ? FileImage(person.file!) : null,
        child: person.file == null
            ? Text(
                person.name.characters.first,
                style: const TextStyle(fontSize: 28, color: Colors.white),
              )
            : null,
        radius: 26,
        backgroundColor: Colors.green,
      ),
      title: Text(person.name, style: const TextStyle(fontSize: 20)),
      subtitle: Text(person.phone, style: const TextStyle(fontSize: 16)),
      onTap: () => handleOpenDialog(context),
      trailing: IconButton(
        icon: const Icon(Icons.call),
        onPressed: () => handleCall(context),
      ),
    );
  }
}

class CustomBody extends StatefulWidget {
  const CustomBody({Key? key}) : super(key: key);

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  Future<void> onNavigateNewContactScreen(BuildContext context, Person? person, int? idx) async {
    Map<String, dynamic>? data = await Navigator.pushNamed(
      context,
      NewContactScreen.newContactScreenName,
      arguments: person != null
          ? {
              'person': person,
              'idx': idx,
            }
          : null,
    ) as Map<String, dynamic>?;
    if (data != null && data['person'] != null) {
      Person p = data['person'] as Person;
      if (data['idx'] == null) {
        BlocProvider.of<ContactBloc>(context).add(AddContact(p));
      } else {
        BlocProvider.of<ContactBloc>(context).add(UpdateContact(p, data['idx']));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, HistoryScreen.historyScreenName),
        child: const Icon(Icons.history),
      ),
      appBar: AppBar(
        title: const Text(
          "Contacts",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              child: const Center(
                child: Text(
                  "Create New Contact",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              onTap: () => onNavigateNewContactScreen(context, null, null),
            ),
          )
        ],
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) => ListView.builder(
          itemBuilder: (context, index) => CustomCard(
            person: state.data[index],
            onDelete: () => BlocProvider.of<ContactBloc>(context).add(DeleteContact(index)),
            onUpdate: () => onNavigateNewContactScreen(context, state.data[index], index),
          ),
          padding: const EdgeInsets.only(top: 8),
          itemCount: state.data.length,
        ),
      ),
    );
  }
}
