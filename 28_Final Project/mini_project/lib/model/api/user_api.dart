import 'package:mini_project/model/user_model.dart';
import 'package:mini_project/services/services.dart';

class UserAPI {
  static Future<UserResult> updateProfilePicture(
      {required UpdateProfilePictureInput input, required String id}) async {
    Services repo = Services();
    final response = await repo.patch(url: 'Users/$id', data: input);
    return await Future.value(UserResult.fromJson(response));
  }
}
