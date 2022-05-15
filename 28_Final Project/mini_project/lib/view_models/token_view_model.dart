import 'package:flutter/material.dart';
import 'package:mini_project/services/local_storage.dart';
import 'package:mini_project/services/services.dart';

const tokenKey = "auth_token";

class TokenViewModel extends ChangeNotifier {
  void changeState() {
    notifyListeners();
  }

  Future<void> setToken({required String token}) async {
    LocalStorage ls = LocalStorage();
    await ls.set(spKey: tokenKey, data: token);
    notifyListeners();
  }

  Future<String?> setupToken() async {
    LocalStorage ls = LocalStorage();
    String? curToken = await ls.get(spKey: tokenKey);
    Services.assignToken(curToken);
    return await Future.value(curToken);
  }

  Future<void> revokeToken() async {
    LocalStorage ls = LocalStorage();
    await ls.remove(spKey: tokenKey);
    notifyListeners();
  }
}
