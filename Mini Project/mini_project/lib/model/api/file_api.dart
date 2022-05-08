import 'package:dio/dio.dart';
import 'package:mini_project/model/file_model.dart';
import 'package:mini_project/services/services.dart';

class FileAPI {
  static Future<File> upload({required FormData input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'storage/upload', data: input);
    return await Future.value(File.fromJson(response));
  }
}
