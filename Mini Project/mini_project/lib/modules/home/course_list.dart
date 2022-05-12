import 'package:flutter/material.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/courses_view_model.dart';
import 'package:mini_project/widgets/components/common/course_card.dart';
import 'package:mini_project/widgets/components/common/error_view.dart';
import 'package:provider/provider.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  void getCourses() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CoursesViewModel>(context, listen: false).getCourses();
    });
  }

  @override
  void didChangeDependencies() {
    getCourses();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesViewModel>(builder: (_, state, ___) {
      if (state.courses?.status == ApiStatus.error) {
        return SliverToBoxAdapter(
          child: ErrorView(errorMessage: state.courses?.message ?? "", refetch: getCourses),
        );
      }
      return (state.courses?.status == ApiStatus.loading
          ? const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 12),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CourseCard(course: state.courses!.data![index]);
                },
                childCount: state.courses?.data?.length ?? 0,
              ),
            ));
    });
  }
}
