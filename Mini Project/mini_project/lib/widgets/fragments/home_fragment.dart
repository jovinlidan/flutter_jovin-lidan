import 'package:flutter/material.dart';
import 'package:mini_project/modules/home/course_list.dart';
import 'package:mini_project/modules/home/home_profile.dart';
import 'package:mini_project/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      print(Provider.of<UserViewModel>(context, listen: false).user?.data?.email);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // return const CustomScrollView(slivers: [HomeCourse()]);
    return const Padding(
      padding: EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeProfile(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 32,
            ),
          ),
          // SliverToBoxAdapter(child: HomeCarousel()),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 32,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              "Courses",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          CourseList()
        ],
      ),
    );
  }
}
