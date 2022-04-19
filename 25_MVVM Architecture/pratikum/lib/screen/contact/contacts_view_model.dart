import 'package:flutter/material.dart';
import 'package:pratikum/model/api/contact_api.dart';
import 'package:pratikum/model/contact_model.dart';
import 'package:pratikum/repositories.dart';

class ContactsViewModel with ChangeNotifier {
  ApiResponse<List<Contact>> _contacts = ApiResponse(status: ApiStatus.success, data: []);

  ApiResponse<List<Contact>> get contacts => _contacts;

  void changeState(ApiResponse<List<Contact>> state) {
    _contacts = state;
    notifyListeners();
  }

  getAllContacts() async {
    changeState(ApiResponse(status: ApiStatus.loading));
    final __contacts = await ContactAPI.getContacts();
    changeState(ApiResponse(status: ApiStatus.success, data: __contacts));
  }
}
