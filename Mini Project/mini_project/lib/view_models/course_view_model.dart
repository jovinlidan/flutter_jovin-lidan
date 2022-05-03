import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/course_api.dart';
import 'package:mini_project/model/course_model.dart';
import 'package:mini_project/services/services.dart';

class CourseViewModel with ChangeNotifier {
  ApiResponse<Course>? _course = ApiResponse(status: ApiStatus.success);
  ApiResponse<Course>? get course => _course;

  void changeState(ApiResponse<Course>? state) {
    _course = state;
    notifyListeners();
  }

  Future<ApiResponse<Course>> getCourse({required String id}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await CourseAPI.getCourse(id: id);
      changeState(ApiResponse<Course>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        changeState(
          ApiResponse(
              status: ApiStatus.error,
              message:
                  (e.response?.data ?? {'message': e.message} as dynamic)['message'] as dynamic),
        );
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
      }
    }
    return Future.value(_course);
  }
}
