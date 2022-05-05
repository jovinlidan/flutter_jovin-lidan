import 'package:flutter/material.dart';
import 'package:mini_project/constants/color.constant.dart';
import 'package:mini_project/helpers/providers/form_manager.dart';
import 'package:mini_project/helpers/validator.dart';
import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/create_post_view_model.dart';
import 'package:mini_project/view_models/posts_view_model.dart';
import 'package:mini_project/view_models/user_view_model.dart';
import 'package:mini_project/widgets/form.dart';
import 'package:mini_project/widgets/inputs/text_input.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  late final FormManager _formManager;

  @override
  void initState() {
    _formManager = FormManager();
    super.initState();
  }

  void onSubmit() async {
    if (_formManager.erroredFields.isEmpty) {
      final PostInput input = PostInput(
          description: _formManager.getValueForField('description'),
          user: [context.read<UserViewModel>().user?.data?.sId ?? ""]);

      final res =
          await Provider.of<CreatePostViewModel>(context, listen: false).createPost(input: input);
      if (res.status == ApiStatus.success) {
        await Provider.of<PostsViewModel>(context, listen: false).getPosts();
        Navigator.pop(context);
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Consumer<CreatePostViewModel>(
              builder: (_, state, __) => IconButton(
                onPressed: state.postResult?.status == ApiStatus.loading ? null : onSubmit,
                icon: state.postResult?.status == ApiStatus.loading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator())
                    : const Icon(Icons.send),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: FormProvider(
              changeNotifier: _formManager,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              builder: (state) => Column(
                children: [
                  TextInput(
                    name: "description",
                    minLines: null,
                    maxLines: null,
                    placeholder: "What's on your mind?",
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
        ),
      ),
    );
  }
}
