import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/constants/color.constant.dart';
import 'package:mini_project/model/post_model.dart';

class PostHeader extends StatelessWidget {
  final Post post;
  const PostHeader({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post.user == null || post.user!.isEmpty) return Container();
    return Row(
      children: [
        post.user![0].pictureUrl != null && post.user![0].pictureUrl != '-'
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    post.user![0].pictureUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : const CircleAvatar(),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(post.user![0].firstName!,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(
              height: 4,
            ),
            Text(DateFormat('dd/MM/yyyy, HH:mm:ss aa').format(post.createdAt!),
                style: const TextStyle(color: Colors.white, fontSize: 10)),
          ],
        )
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final bool hasDetail;
  const PostCard({Key? key, required this.post, this.hasDetail = true}) : super(key: key);

  void onNavigatePostDetail(BuildContext context) {
    Navigator.pushNamed(context, '/post-detail', arguments: post.sId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasDetail ? () => onNavigatePostDetail(context) : null,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
            color: CustomColors.primary1,
            border:
                Border(bottom: BorderSide(color: CustomColors.primary4, width: hasDetail ? 1 : 2))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(post: post),
            const SizedBox(
              height: 20,
            ),
            Text(post.description!, style: const TextStyle(color: Colors.white)),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.comment_bank_outlined, color: Colors.white),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "${post.comments?.length ?? 0} Comments",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
