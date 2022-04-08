import 'package:flutter/material.dart';
import 'package:pratikum/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactProvider with ChangeNotifier {
  late SharedPreferences prefs;
  ContactProvider() {
    init();
  }

  List<Person> _contacts = [];
  bool _isLoading = false;

  List<Person> get contacts => _contacts;

  bool get isLoading => _isLoading;

  set contacts(List<Person> val) {
    _contacts = val;
    updatePreferences(val);
    notifyListeners();
  }

  void updatePreferences(List<Person> val) async {
    await prefs.setString("personsProvider", Person.encode(val));
  }

  void init() async {
    _isLoading = true;
    prefs = await SharedPreferences.getInstance();
    // Uncomment kode dibawah untuk melihat animasi loading lebih lama
    // await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    String? personsStr = prefs.getString('personsProvider');
    if (personsStr != null) {
      contacts = Person.decode(personsStr);
    }
  }
}
