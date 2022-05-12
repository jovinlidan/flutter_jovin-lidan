import 'package:flutter/material.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/posts_view_model.dart';
import 'package:mini_project/widgets/components/common/error_view.dart';
import 'package:mini_project/widgets/components/common/post_card.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void getPosts() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<PostsViewModel>(context, listen: false).getPosts();
    });
  }

  @override
  void didChangeDependencies() {
    getPosts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsViewModel>(builder: (_, state, ___) {
      if (state.posts?.status == ApiStatus.error) {
        return ErrorView(errorMessage: state.posts?.message ?? "", refetch: getPosts);
      }
      return (state.posts?.status != ApiStatus.loading
          ? Column(
              children: (state.posts?.data ?? []).map((post) => PostCard(post: post)).toList(),
            )
          : const Center(child: CircularProgressIndicator()));
    });
  }
}
