import 'package:flutter/material.dart';

class Person {
  String name;
  String phone;

  Person({required this.name, required this.phone});
}

class ContactProvider with ChangeNotifier {
  List<Person> _contacts = [
    Person(name: "Leane Grahams", phone: "0812314362"),
    Person(name: "Hwang ni", phone: "0812314362"),
  ];

  List<Person> get contacts => _contacts;

  set contacts(List<Person> val) {
    _contacts = val;
    notifyListeners();
  }
}
