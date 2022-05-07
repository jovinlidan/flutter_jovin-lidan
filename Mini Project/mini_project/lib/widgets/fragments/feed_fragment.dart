import 'package:flutter/material.dart';
import 'package:mini_project/constants/color.constant.dart';
import 'package:mini_project/modules/home/post_list.dart';
import 'package:mini_project/view_models/posts_view_model.dart';
import 'package:provider/provider.dart';

class FeedFragment extends StatelessWidget {
  const FeedFragment({Key? key}) : super(key: key);

  Future<dynamic> onRefresh(BuildContext ctx) async {
    return await Provider.of<PostsViewModel>(ctx, listen: false).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.primary1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 12, top: 12),
            child: Text(
              "Feed",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: CustomColors.primary2, width: 1),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => onRefresh(context),
              child: ListView(
                children: const [
                  PostList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
