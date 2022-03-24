import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pratikum/create_post_screen.dart';

class PreviewPostScreen extends StatelessWidget {
  const PreviewPostScreen({Key? key}) : super(key: key);
  static const previewPostScreenName = "/preview-post-screen";
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as FormData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Post"),
        backgroundColor: const Color.fromRGBO(21, 84, 246, 1),
        centerTitle: false,
      ),
      drawer: const CustomDrawer(),
      body: CustomBody(data: data),
    );
  }
}

class CustomBody extends StatelessWidget {
  final FormData data;
  const CustomBody({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 8,
            child: Image.file(data.file!, fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text("Published: ${DateFormat('dd/MM/yyyy').format(data.date!)} ",
                    style: const TextStyle(color: Colors.black45)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Color: ", style: TextStyle(color: Colors.black45)),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: data.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Text(data.caption ?? "", style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[900],
                    radius: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Jovin Lidan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "+6281-2345-6789",
                  style: TextStyle(color: Colors.white),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
            title: const Text(
              'Back to Create Post Screen',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
