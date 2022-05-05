import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/constants/color.constant.dart';
import 'package:mini_project/model/post_comment_model.dart';

class PostCommentHeader extends StatelessWidget {
  final PostComment comment;
  const PostCommentHeader({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (comment.user == null || comment.user!.isEmpty) return Container();
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
            Text(comment.user![0].firstName!,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(
              height: 4,
            ),
            Text(DateFormat('dd/MM/yyyy, HH:mm:ss aa').format(comment.createdAt!),
                style: const TextStyle(color: Colors.white, fontSize: 10)),
          ],
        )
      ],
    );
  }
}

class PostCommentCard extends StatelessWidget {
  final PostComment comment;
  final bool hasDetail;
  const PostCommentCard({Key? key, required this.comment, this.hasDetail = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: const BoxDecoration(
          color: CustomColors.primary1,
          border: Border(bottom: BorderSide(color: CustomColors.primary4, width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostCommentHeader(comment: comment),
          const SizedBox(
            height: 20,
          ),
          Text(comment.description!, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
