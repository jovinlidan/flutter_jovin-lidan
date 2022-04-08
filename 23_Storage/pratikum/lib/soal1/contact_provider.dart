import 'package:flutter/material.dart';
import 'package:pratikum/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactProvider with ChangeNotifier {
  late SharedPreferences prefs;
  ContactProvider() {
    init();
  }

  List<Person> _contacts = [];

  List<Person> get contacts => _contacts;

  set contacts(List<Person> val) {
    _contacts = val;
    updatePreferences(val);
    notifyListeners();
  }

  void updatePreferences(List<Person> val) async {
    await prefs.setString("personsProvider", Person.encode(val));
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    String? personsStr = prefs.getString('personsProvider');
    if (personsStr != null) {
      contacts = Person.decode(personsStr);
    }
  }
}
