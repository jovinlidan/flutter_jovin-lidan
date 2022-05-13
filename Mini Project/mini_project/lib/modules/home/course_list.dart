import 'package:flutter/material.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/modules_view_model.dart';
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
      Provider.of<ModulesViewModel>(context, listen: false).getModules();
    });
  }

  @override
  void didChangeDependencies() {
    getCourses();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModulesViewModel>(builder: (_, state, ___) {
      if (state.modules?.status == ApiStatus.error) {
        return SliverToBoxAdapter(
          child: ErrorView(errorMessage: state.modules?.message ?? "", refetch: getCourses),
        );
      }
      return (state.modules?.status == ApiStatus.loading
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
                  return CourseCard(course: state.modules!.data![index]);
                },
                childCount: state.modules?.data?.length ?? 0,
              ),
            ));
    });
  }
}
