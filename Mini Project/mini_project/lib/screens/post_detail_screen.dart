import 'package:flutter/material.dart';
import 'package:mini_project/constants/color.constant.dart';
import 'package:mini_project/helpers/providers/form_manager.dart';
import 'package:mini_project/helpers/validator.dart';
import 'package:mini_project/model/post_comment_model.dart';
import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/create_post_comment_view_model.dart';
import 'package:mini_project/view_models/delete_post_view_model.dart';
import 'package:mini_project/view_models/post_comments_view_model.dart';
import 'package:mini_project/view_models/post_view_model.dart';
import 'package:mini_project/view_models/posts_view_model.dart';
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

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CustomColors.primary1,
          title: const Text('Hapus Postingan?', style: TextStyle(color: Colors.white70)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah anda yakin ingin menghapus postingan ini?',
                    style: TextStyle(color: Colors.white70)),
                SizedBox(
                  height: 8,
                ),
                Text('Langkah ini tidak dapat dibatalkan',
                    style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () => onDeletePost(context),
            ),
          ],
        );
      },
    );
  }

  void onDeletePost(BuildContext context) async {
    final res = await Provider.of<DeletePostViewModel>(context, listen: false)
        .deletePost(postId: widget.id);
    if (res.status == ApiStatus.success) {
      Provider.of<PostsViewModel>(context, listen: false).getPosts();
      Navigator.of(context).popUntil((route) => route.settings.name == '/');
    } else {
      if (res.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message!)));
      }
    }
  }

  Future<dynamic> onRefresh(BuildContext context) async {
    return await Provider.of<PostViewModel>(context, listen: false).getPost(id: widget.id);
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
        actions: [
          Consumer<PostViewModel>(
            builder: (_, state, __) => state.post?.status != ApiStatus.loading &&
                    state.post?.data != null
                ? state.post?.data?.user![0].sId == context.read<UserViewModel>().user?.data?.sId
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Consumer<DeletePostViewModel>(
                          builder: (_, state, __) => IconButton(
                            onPressed: state.postResult?.status == ApiStatus.loading
                                ? null
                                : () => _showMyDialog(context),
                            icon: state.postResult?.status == ApiStatus.loading
                                ? const SizedBox(
                                    width: 16, height: 16, child: CircularProgressIndicator())
                                : const Icon(Icons.delete_forever_outlined, color: Colors.red),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => onRefresh(context),
                child: ListView(
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
