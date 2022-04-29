import 'package:flutter/material.dart';
import 'package:mini_project/modules/home/home_carousel.dart';
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HomeProfile(),
          SizedBox(
            height: 32,
          ),
          HomeCarousel(),
        ],
      ),
    );
  }
}
