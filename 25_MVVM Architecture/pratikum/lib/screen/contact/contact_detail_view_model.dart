import 'package:flutter/material.dart';
import 'package:pratikum/model/api/contact_api.dart';
import 'package:pratikum/model/contact_model.dart';
import 'package:pratikum/repositories.dart';

class ContactDetailViewModel with ChangeNotifier {
  ApiResponse<Contact>? _contact = ApiResponse(status: ApiStatus.loading);

  ApiResponse<Contact>? get contact => _contact;

  void changeState(ApiResponse<Contact>? state) {
    _contact = state;
    notifyListeners();
  }

  getContact({required int id}) async {
    changeState(ApiResponse<Contact>(status: ApiStatus.loading));
    final __contact = await ContactAPI.getContact(id: id);
    changeState(ApiResponse<Contact>(status: ApiStatus.success, data: __contact));
  }
}
