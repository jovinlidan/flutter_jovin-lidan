import 'package:flutter/material.dart';
import 'package:pratikum/model.dart';
import 'package:pratikum/repositories.dart';

class ContactProvider with ChangeNotifier {
  Repositories repo = Repositories(repoKey: "personsProvider");
  ContactProvider() {
    init();
  }

  List<Person> _contacts = [];

  List<Person> get contacts => _contacts;

  bool get isLoading => repo.isLoading;

  set contacts(List<Person> val) {
    _contacts = val;
    updatePreferences(val);
    notifyListeners();
  }

  void updatePreferences(List<Person> val) async {
    await repo.setData(Person.encode(val));
  }

  void init() async {
    String? personsStr = await repo.getData();
    if (personsStr != null) {
      contacts = Person.decode(personsStr);
    }
  }
}
