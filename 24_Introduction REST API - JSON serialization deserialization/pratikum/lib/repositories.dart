import 'package:dio/dio.dart';

class Repositories {
  static Dio? _dio;

  Repositories._internal() {
    // ignore: prefer_conditional_assignment
    if (_dio == null) {
      // Jika instance belum ada, maka lakukan inisialisasi
      _dio = Dio();
    }
  }
  factory Repositories() {
    return Repositories._internal();
  }

  Future<dynamic>? get({required String url}) async {
    Response<dynamic>? res = await _dio?.get(url);
    return Future.value(res?.data);
  }

  void post<T>({required String url, required T data}) async {
    await _dio?.post(url, data: data);
  }
}
