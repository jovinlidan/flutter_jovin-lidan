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
        const CircleAvatar(),
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
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: const BoxDecoration(
            color: CustomColors.primary1,
            border: Border(bottom: BorderSide(color: CustomColors.primary4, width: 1))),
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
                Text("${post.comments?.length ?? 0} Comments",
                    style: const TextStyle(
                      color: Colors.white,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
