import 'package:flutter/material.dart';
import 'package:pratikum/badge.dart';

class Soal1 extends StatelessWidget {
  const Soal1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Telegram",
            style: TextStyle(fontSize: 20),
          ),
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
        ListTile(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Jovin Lidan",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("5:54 PM", style: TextStyle(fontSize: 12, color: Colors.grey[600]))
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jovin: Wow, nice🤪🤪",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const CustomBadges(
                    color: Colors.green,
                    size: 24,
                    child: Text("1", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
          leading: const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 30,
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
      padding: const EdgeInsets.only(top: 8),
      children: const [
        CustomChat(),
        CustomChat(),
        CustomChat(),
        CustomChat(),
        CustomChat(),
        CustomChat(),
        CustomChat(),
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
