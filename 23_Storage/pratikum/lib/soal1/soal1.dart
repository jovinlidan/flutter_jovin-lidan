import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pratikum/model.dart';
import 'package:pratikum/soal1/new_contact_screen.dart';
import 'package:pratikum/soal1/contact_provider.dart';
import 'package:provider/provider.dart';

class Soal1 extends StatelessWidget {
  const Soal1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ChangeNotifierProvider<ContactProvider>(
              create: (_) => ContactProvider(),
              child: const CustomBody(),
            ),
        NewContactScreen.newContactScreenName: (context) => const NewContactScreen()
      },
      debugShowCheckedModeBanner: false,
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
    );
  }
}

class CustomBody extends StatefulWidget {
  const CustomBody({Key? key}) : super(key: key);

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  Future<void> onNavigateNewContactScreen(
      BuildContext context, ContactProvider contactProvider, Person? person, int? idx) async {
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
        contactProvider.contacts = [...contactProvider.contacts, p];
      } else {
        List<Person> temp = [...contactProvider.contacts];
        temp[data['idx']] = p;
        contactProvider.contacts = temp;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contacts",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<ContactProvider>(
              builder: (_, data, __) => InkWell(
                child: const Center(
                  child: Text(
                    "Create New Contact",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () => onNavigateNewContactScreen(context, data, null, null),
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => CustomCard(
          person: context.read<ContactProvider>().contacts[index],
          onDelete: () {
            List<Person> temp = context.read<ContactProvider>().contacts;
            temp.removeAt(index);
            context.watch<ContactProvider>().contacts = temp;
          },
          onUpdate: () => onNavigateNewContactScreen(context, context.watch<ContactProvider>(),
              context.read<ContactProvider>().contacts[index], index),
        ),
        padding: const EdgeInsets.only(top: 8),
        itemCount: context.read<ContactProvider>().contacts.length,
      ),
    );
  }
}
