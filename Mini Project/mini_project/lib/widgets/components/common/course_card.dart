import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/model/course_model.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({Key? key, required this.course}) : super(key: key);

  void onNavigateCourseDetail(BuildContext context) {
    Navigator.pushNamed(context, '/course-detail', arguments: course.sId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onNavigateCourseDetail(context),
      child: Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network("", fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text("· ${course.duration}", style: const TextStyle(color: Colors.grey, fontSize: 10)),
          const SizedBox(
            height: 4,
          ),
          Text(course.title!,
              style:
                  const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 4,
          ),
          Text(DateFormat('E dd MMM yyy').format(course.createdAt!),
              style: const TextStyle(color: Colors.grey, fontSize: 10))
        ]),
      ),
    );
  }
}
