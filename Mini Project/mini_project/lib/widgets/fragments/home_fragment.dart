import 'package:flutter/material.dart';
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
      final res = await Provider.of<UserViewModel>(context, listen: false).getMe();
      print(res.data?.email);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
