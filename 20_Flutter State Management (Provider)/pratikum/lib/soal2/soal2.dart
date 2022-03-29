import 'package:flutter/material.dart';
import 'package:pratikum/soal2/new_contact_screen.dart';
import 'package:pratikum/soal2/contact_provider.dart';
import 'package:provider/provider.dart';

class Soal2 extends StatelessWidget {
  const Soal2({Key? key}) : super(key: key);

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
  const CustomCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      leading: CircleAvatar(
        child: Text(
          person.name.characters.first,
          style: const TextStyle(fontSize: 28, color: Colors.white),
        ),
        radius: 26,
        backgroundColor: Colors.green,
      ),
      title: Text(person.name, style: const TextStyle(fontSize: 20)),
      subtitle: Text(person.phone, style: const TextStyle(fontSize: 16)),
      onTap: () {},
    );
  }
}

class CustomBody extends StatefulWidget {
  const CustomBody({Key? key}) : super(key: key);

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  Future<void> onNavigateNewContactScreen(BuildContext context, ContactProvider data) async {
    Person? res = await Navigator.pushNamed(
      context,
      NewContactScreen.newContactScreenName,
    ) as Person?;
    if (res != null) {
      data.contacts = [...data.contacts, res];
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
                onTap: () => onNavigateNewContactScreen(context, data),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8),
        children: context
            .watch<ContactProvider>()
            .contacts
            .map((person) => CustomCard(person: person))
            .toList(),
      ),
    );
  }
}
