import 'package:dio/dio.dart';
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
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final __contacts = await ContactAPI.getContacts();
      changeState(ApiResponse(status: ApiStatus.success, data: __contacts));
    } catch (e) {
      if (e is DioError) {
        changeState(ApiResponse(status: ApiStatus.error, message: e.message));
        return;
      }
      changeState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
    }
  }
}
