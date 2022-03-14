import 'package:flutter/material.dart';

class Soal1 extends StatelessWidget {
  const Soal1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Telegram"),
          centerTitle: false,
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: const CustomBody(),
        drawer: const CustomDrawer(),
      ),
    );
  }
}

class CustomChat extends StatelessWidget {
  const CustomChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jovin Lidan",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Jovin: Wow, nice",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 24,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class CustomBody extends StatelessWidget {
  const CustomBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CustomChat(),
        CustomChat(),
        CustomChat(),
        CustomChat(),
        CustomChat(),
        CustomChat(),
        CustomChat(),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[900],
                    radius: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Jovin Lidan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "+6281-2345-6789",
                  style: TextStyle(color: Colors.white),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          const ListTile(
            title: Text(
              'New Group',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.people),
          ),
          const ListTile(
            title: Text(
              'New Secret Chat',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.lock),
          ),
          const ListTile(
            title: Text(
              'New Channel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.phone_callback),
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'Contacts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.contacts),
          ),
          const ListTile(
            title: Text(
              'Invite Friends',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.person_pin_circle),
          ),
          const ListTile(
            title: Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.settings),
          ),
          const ListTile(
            title: Text(
              'Telegram FAQ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.question_answer),
          ),
        ],
      ),
    );
  }
}
