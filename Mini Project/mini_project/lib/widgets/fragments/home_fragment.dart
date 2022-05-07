import 'package:flutter/material.dart';
import 'package:mini_project/modules/home/home_carousel.dart';
import 'package:mini_project/modules/home/home_profile.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
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
          SliverToBoxAdapter(child: HomeCarousel()),
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
          // CourseList()
        ],
      ),
    );
  }
}
