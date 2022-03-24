import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:pratikum/label.dart';
import 'package:pratikum/preview_post_screen.dart';

class FormData {
  String? file;
  Color? color;
  DateTime? date;
  String? caption;

  bool isValid() {
    return (file?.isNotEmpty ?? false) &&
        color != null &&
        date != null &&
        (caption?.isNotEmpty ?? false);
  }
}

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        centerTitle: false,
        backgroundColor: const Color.fromRGBO(21, 84, 246, 1),
      ),
      drawer: const CustomDrawer(),
      body: const FormWidget(),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormState();
}

class _FormState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  // Map<String, dynamic> formValue = {};

  FormData formValue = FormData();

  void handlePickFile() async {
    FilePickerResult? res = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (res != null) {
      File file = File(res.files.single.path!);
      setState(() {
        formValue.file = file.path;
      });
    }
  }

  void handlePickDate(BuildContext context) async {
    DateTime? res = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(DateTime.now().year + 1000));
    if (res != null) {
      setState(() {
        formValue.date = res;
      });
    }
  }

  void handlePickColor(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Pick Color"),
            content: ColorPicker(
              pickerColor: formValue.color ?? Colors.red,
              onColorChanged: (color) => setState(() {
                formValue.color = color;
              }),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (formValue.color == null) {
                    setState(() {
                      formValue.color = Colors.red;
                    });
                  }
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              )
            ],
          );
        });
  }

  void onNavigatePreviewPostScreen(context) {
    Navigator.pushNamed(context, PreviewPostScreen.previewPostScreenName, arguments: formValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LabelWidget(label: "Cover"),
            ElevatedButton(
              onPressed: handlePickFile,
              child: Text(formValue.file != null
                  ? "Ubah File (${formValue.file?.split('/')[(formValue.file?.split('/').length)! - 1]})"
                  : "Pilih File"),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
            ),
            const LabelWidget(label: "Publish At"),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: InkWell(
                onTap: () => handlePickDate(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    formValue.date != null
                        ? DateFormat('dd/MM/yyyy').format(formValue.date!)
                        : 'dd/mm/yyyy',
                    style: TextStyle(color: formValue.date != null ? Colors.black : Colors.black45),
                  ),
                ),
              ),
            ),
            const LabelWidget(label: "Color Theme"),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: InkWell(
                onTap: () => handlePickColor(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            formValue.color != null
                                ? '#${formValue.color?.value.toRadixString(16).substring(2, 8).toString().toUpperCase()}'
                                : 'Pick a color',
                            style: TextStyle(
                                color: formValue.color != null ? Colors.black : Colors.black45),
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            color: formValue.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const LabelWidget(label: "Caption"),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              minLines: 10,
              maxLines: 10,
              onChanged: (val) => setState(() {
                formValue.caption = val;
              }),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(8)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 28),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: formValue.isValid() ? () => onNavigatePreviewPostScreen(context) : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  primary: const Color.fromRGBO(21, 84, 246, 1),
                ),
                child: const Text("Simpan"),
              ),
            )
          ],
        ),
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
        ],
      ),
    );
  }
}
