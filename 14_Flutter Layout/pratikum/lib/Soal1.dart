import 'package:flutter/material.dart';

class Person {
  String name;
  String phone;

  Person({required this.name, required this.phone});
}

class Soal1 extends StatelessWidget {
  Soal1({Key? key}) : super(key: key);

  final List<Person> datas = [
    Person(name: "Leane Graham", phone: "0812314362"),
    Person(name: "Hwang ni", phone: "0812314362"),
    Person(name: "Ionis", phone: "0812314362"),
    Person(name: "Gangwang", phone: "0812314362"),
    Person(name: "Jovin Lidan", phone: "08128233131"),
    Person(name: "Clementine Baunch", phone: "0898378313"),
    Person(name: "Ayam Goreng", phone: "09238288328"),
    Person(name: "Rebus Ayam", phone: "082327323323"),
    Person(name: "Tengah Malem", phone: "0823562532"),
    Person(name: "Jagung", phone: "08234782352"),
    Person(name: "Soul", phone: "028723642134"),
    Person(name: "Singkong", phone: "08234782352"),
    Person(name: "Saranghae", phone: "026423587235"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("JSON ListView in Flutters"),
          centerTitle: false,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 8),
          children: datas.map((person) => CustomCard(person: person)).toList(),
        ),
      ),
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
