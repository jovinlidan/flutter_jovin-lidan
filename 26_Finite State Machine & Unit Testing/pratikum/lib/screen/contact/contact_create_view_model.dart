import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pratikum/model/api/contact_api.dart';
import 'package:pratikum/model/contact_model.dart';
import 'package:pratikum/repositories.dart';

class ContactCreateViewModel extends ChangeNotifier {
  ApiResponse<Contact>? _contact = ApiResponse(status: ApiStatus.success);

  ApiResponse<Contact>? get contact => _contact;

  void changeState(ApiResponse<Contact>? state) {
    _contact = state;
    notifyListeners();
  }

  Future<ApiResponse<Contact>?> postContact({required Contact contact}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final __contact = await ContactAPI.postContact(contact: contact);
      changeState(ApiResponse<Contact>(data: __contact, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        changeState(ApiResponse(status: ApiStatus.error, message: e.message));
      }
      changeState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
    }
    return _contact;
  }
}
