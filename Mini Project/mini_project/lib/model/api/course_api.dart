import 'package:mini_project/model/course_model.dart';
import 'package:mini_project/services/services.dart';

class CourseAPI {
  static Future<List<Course>> getCourses() async {
    Services repo = Services();
    final response = await repo.get(url: 'Course');
    return await Future.value(response.map<Course>((e) => Course.fromJson(e)).toList());
  }

  static Future<Course> getCourse({required id}) async {
    Services repo = Services();
    final response = await repo.get(url: 'Course/$id');
    return await Future.value(Course.fromJson(response));
  }
}
