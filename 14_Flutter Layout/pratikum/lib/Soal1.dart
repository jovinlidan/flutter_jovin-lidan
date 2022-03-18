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
    Person(name: "Jovin Lidan", phone: "08128233131"),
    Person(name: "Clementine Baunch", phone: "0898378313"),
    Person(name: "Ayam Goreng", phone: "09238288328"),
    Person(name: "Rebus Ayam", phone: "082327323323"),
    Person(name: "Tengah Malem", phone: "0823562532"),
    Person(name: "Jagung", phone: "08234782352"),
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
      leading: CircleAvatar(
        child: Text(person.name.characters.first),
        radius: 20,
      ),
    );
  }
}
