import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/course_api.dart';
import 'package:mini_project/model/course_model.dart';
import 'package:mini_project/services/services.dart';

class CoursesViewModel with ChangeNotifier {
  ApiResponse<List<Course>>? _courses = ApiResponse(status: ApiStatus.success);
  ApiResponse<List<Course>>? get courses => _courses;

  void changeState(ApiResponse<List<Course>>? state) {
    _courses = state;
    notifyListeners();
  }

  Future<ApiResponse<List<Course>>> getCourses() async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await CourseAPI.getCourses();
      changeState(ApiResponse<List<Course>>(data: res, status: ApiStatus.success));
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
    return Future.value(_courses);
  }
}
