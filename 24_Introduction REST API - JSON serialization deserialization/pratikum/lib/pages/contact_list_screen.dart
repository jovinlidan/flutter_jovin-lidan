import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratikum/api-class/contact.model.dart';
import 'package:pratikum/api-class/contact.query.dart';
import 'package:pratikum/pages/new_contact_screen.dart';

class Soal1Soal2 extends StatelessWidget {
  const Soal1Soal2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const CustomBody(),
        NewContactScreen.newContactScreenName: (context) => const NewContactScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomCard extends StatelessWidget {
  final Contact person;
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
  List<Contact> data = [];
  GetContacts getContacts = GetContacts();
  @override
  void initState() {
    initContacts();
    super.initState();
  }

  void initContacts() async {
    try {
      List<Contact> res = await getContacts.get();
      setState(() {
        data = res;
      });
    } catch (e) {
      if (e is DioError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  Future<void> onNavigateNewContactScreen(BuildContext context) async {
    Contact? res = await Navigator.pushNamed(
      context,
      NewContactScreen.newContactScreenName,
    ) as Contact?;
    if (res != null) {
      setState(() {
        data = [...data, res];
      });
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
              onTap: () => onNavigateNewContactScreen(context),
            ),
          )
        ],
      ),
      body: getContacts.isLoading
          ? const Center(
              child: LoadingIndicator(indicatorType: Indicator.ballClipRotatePulse),
            )
          : ListView(
              padding: const EdgeInsets.only(top: 8),
              children: data.map((person) => CustomCard(person: person)).toList(),
            ),
    );
  }
}
