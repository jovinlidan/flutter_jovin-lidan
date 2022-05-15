import 'package:mini_project/model/auth_model.dart';
import 'package:mini_project/model/user_model.dart';
import 'package:mini_project/services/services.dart';

class AuthAPI {
  static Future<TokenResult> login({required LoginInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'auth/login', data: input);
    return await Future.value(TokenResult.fromJson(response));
  }

  static Future<TokenResult> register({required RegisterInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'auth/register', data: input);
    return await Future.value(TokenResult.fromJson(response));
  }

  static Future<User> getMe() async {
    Services repo = Services();
    final response = await repo.get(url: 'auth/user');
    return await Future.value(User.fromJson(response));
  }
}
