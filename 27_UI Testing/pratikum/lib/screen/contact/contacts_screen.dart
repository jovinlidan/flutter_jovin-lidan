import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratikum/model/contact_model.dart';
import 'package:pratikum/repositories.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ContactsViewModel>(context, listen: false).getAllContacts();
    });
    super.didChangeDependencies();
  }

  Future<void> onNavigateNewContactScreen(BuildContext context) async {
    Navigator.pushNamed(context, '/contact-create');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: const [Icon(Icons.contact_mail), SizedBox(width: 16), Text('Contacts')],
              ),
            ),
            ListTile(
              title: Row(
                children: const [Icon(Icons.contact_mail), SizedBox(width: 16), Text('Contacts')],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/", (route) => route.isCurrent && route.settings.name == "/" ? false : true);
              },
            ),
            ListTile(
              title: Row(
                children: const [Icon(Icons.fastfood), SizedBox(width: 16), Text('Foods')],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil("/foods",
                    (route) => route.isCurrent && route.settings.name == "/foods" ? false : true);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.contact_mail),
          onPressed: () => Navigator.pushNamed(context, '/contact-counts')),
      appBar: AppBar(
        title: const Text(
          "Contacts",
          style: TextStyle(fontSize: 20),
          key: ValueKey('ContactKey'),
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
      body: Consumer<ContactsViewModel>(
        builder: ((_, value, __) => value.contacts.status == ApiStatus.loading
            ? const Center(
                child: LoadingIndicator(indicatorType: Indicator.ballClipRotatePulse),
              )
            : value.contacts.status == ApiStatus.error
                ? Center(child: Text("${value.contacts.message}"))
                : ListView(
                    padding: const EdgeInsets.only(top: 8),
                    children: value.contacts.data!.map((e) => CustomCard(person: e)).toList(),
                  )),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Contact person;
  const CustomCard({Key? key, required this.person}) : super(key: key);

  void onNavigateContactDetailScreen(BuildContext context) async {
    Navigator.pushNamed(context, '/contact-detail', arguments: person.id);
  }

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
      onTap: () => onNavigateContactDetailScreen(context),
    );
  }
}
