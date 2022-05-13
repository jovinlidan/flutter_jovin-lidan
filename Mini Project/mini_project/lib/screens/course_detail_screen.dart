import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/model/content_model.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/module_view_model.dart';
import 'package:mini_project/widgets/components/common/content_card.dart';
import 'package:mini_project/widgets/components/common/error_view.dart';
import 'package:mini_project/widgets/components/common/video_player.dart';
import 'package:provider/provider.dart';

class CourseDetailScreen extends StatefulWidget {
  final String id;
  const CourseDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  String? currentUrl;
  String? currentId;

  void getCourse() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      final res =
          await Provider.of<ModuleViewModel>(context, listen: false).getModule(id: widget.id);

      setState(() {
        currentUrl =
            (res.data?.contents?.isNotEmpty ?? false) ? res.data?.contents![0].videoUrl : null;
        currentId = (res.data?.contents?.isNotEmpty ?? false) ? res.data?.contents![0].sId : null;
      });
    });
  }

  @override
  void didChangeDependencies() {
    getCourse();
    super.didChangeDependencies();
  }

  void onChangeVideo(Content content) {
    setState(() {
      currentUrl = content.videoUrl;
      currentId = content.sId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Back", style: TextStyle(fontSize: 14)),
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
      ),
      backgroundColor: const Color.fromRGBO(0, 29, 105, 1),
      body: Consumer<ModuleViewModel>(builder: (_, state, __) {
        if (state.module?.status == ApiStatus.error) {
          return ErrorView(errorMessage: state.module?.message ?? "", refetch: getCourse);
        }
        return (state.module?.status == ApiStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    VideoPlayerWidget(videoUrl: currentUrl ?? ""),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.module?.data?.title ?? "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(state.module?.data?.description ?? "",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text("${state.module?.data?.duration}",
                                  style: const TextStyle(color: Colors.white, fontSize: 13)),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                  DateFormat('E dd MMM yyy')
                                      .format(state.module?.data?.createdAt ?? DateTime.now()),
                                  style: const TextStyle(color: Colors.white, fontSize: 13))
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text("${(state.module?.data?.contents ?? []).length} Videos",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 20),
                          ...(state.module?.data?.contents ?? []).map(
                            (e) => ContentCard(
                                content: e,
                                selected: e.sId == currentId,
                                onTap: () => onChangeVideo(e)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
      }),
    );
  }
}
