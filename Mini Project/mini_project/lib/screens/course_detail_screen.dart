import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/course_view_model.dart';
import 'package:mini_project/widgets/components/common/video_player.dart';
import 'package:provider/provider.dart';

class CourseDetailScreen extends StatefulWidget {
  final String id;
  const CourseDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CourseViewModel>(context, listen: false).getCourse(id: widget.id);
    });
    super.didChangeDependencies();
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
      body: Consumer<CourseViewModel>(
        builder: (_, state, __) => state.course?.status == ApiStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    VideoPlayerWidget(videoUrl: state.course?.data?.videoUrl ?? ""),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.course?.data?.title ?? "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(state.course?.data?.description ?? "",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text("${state.course?.data?.duration}",
                                  style: const TextStyle(color: Colors.white, fontSize: 13)),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                  DateFormat('E dd MMM yyy')
                                      .format(state.course?.data?.createdAt ?? DateTime.now()),
                                  style: const TextStyle(color: Colors.white, fontSize: 13))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
