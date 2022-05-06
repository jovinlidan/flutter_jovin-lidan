import 'package:flutter/material.dart';
import 'package:mini_project/constants/color.constant.dart';
import 'package:mini_project/helpers/providers/form_manager.dart';
import 'package:mini_project/helpers/validator.dart';
import 'package:mini_project/model/post_comment_model.dart';
import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/create_post_comment_view_model.dart';
import 'package:mini_project/view_models/post_comments_view_model.dart';
import 'package:mini_project/view_models/post_view_model.dart';
import 'package:mini_project/view_models/user_view_model.dart';
import 'package:mini_project/widgets/components/common/post_card.dart';
import 'package:mini_project/widgets/components/common/post_comment_card.dart';
import 'package:mini_project/widgets/form.dart';
import 'package:mini_project/widgets/inputs/text_input.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  final String id;
  const PostDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late final FormManager _formManager;

  @override
  void initState() {
    _formManager = FormManager();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<PostViewModel>(context, listen: false).getPost(id: widget.id);
      Provider.of<PostCommentsViewModel>(context, listen: false).getPostComments(postId: widget.id);
    });
    super.didChangeDependencies();
  }

  void onSubmit() async {
    if (_formManager.erroredFields.isEmpty) {
      final PostCommentInput input = PostCommentInput(
        description: _formManager.getValueForField('description'),
        user: [context.read<UserViewModel>().user?.data?.sId ?? ""],
        post: [widget.id],
      );

      final res = await Provider.of<CreatePostCommentViewModel>(context, listen: false)
          .createPostComment(input: input);
      if (res.status == ApiStatus.success) {
        _formManager.resetForm();
        await Provider.of<PostViewModel>(context, listen: false).getPost(id: widget.id);
        Provider.of<PostCommentsViewModel>(context, listen: false)
            .getPostComments(postId: widget.id);
      } else {
        if (res.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message!)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Back", style: TextStyle(fontSize: 14)),
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            // child: Consumer<CreatePostViewModel>(
            //   builder: (_, state, __) => IconButton(
            //     onPressed: state.postResult?.status == ApiStatus.loading ? null : onSubmit,
            //     icon: state.postResult?.status == ApiStatus.loading
            //         ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator())
            //         : const Icon(Icons.send),
            //   ),
            // ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<PostViewModel>(
                      builder: (_, state, __) =>
                          state.post?.status != ApiStatus.loading && state.post?.data != null
                              ? PostCard(
                                  post: state.post?.data! as Post,
                                  hasDetail: false,
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Consumer<PostViewModel>(
                        builder: (_, state, __) => Text(
                            "${state.post?.data?.comments?.length ?? 0} Comments",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Consumer<PostCommentsViewModel>(
                      builder: (_, state, __) => Column(
                        children: [
                          ...state.postComments?.status != ApiStatus.loading &&
                                  state.postComments?.data != null
                              ? (state.postComments!.data!
                                  .map(
                                    (e) => PostCommentCard(
                                      comment: e,
                                    ),
                                  )
                                  .toList())
                              : [
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: CustomColors.primary4, width: 2))),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormProvider(
                      changeNotifier: _formManager,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      builder: (state) => Column(
                        children: [
                          TextInput(
                            name: "description",
                            placeholder: "Add a comment...",
                            validator: (String? val) => Validator.validate(
                              val,
                              [
                                Validator.required,
                              ],
                            ),
                            style: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<CreatePostCommentViewModel>(
                    builder: (_, state, __) => TextButton(
                      onPressed: state.commentResult?.status == ApiStatus.loading ? null : onSubmit,
                      child: state.commentResult?.status == ApiStatus.loading
                          ? const SizedBox(
                              width: 16, height: 16, child: CircularProgressIndicator())
                          : const Text("Post"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
