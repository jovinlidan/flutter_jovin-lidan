import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pratikum/soal1soal2.dart';
import 'package:intl/intl.dart';

class NewContactScreen extends StatefulWidget {
  static const newContactScreenName = "/new-contact";

  const NewContactScreen({Key? key}) : super(key: key);

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

enum RadioOption { laki, perempuan }

class _NewContactScreenState extends State<NewContactScreen> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? phoneNumber;
  List<String> languages = [];
  RadioOption option = RadioOption.laki;
  File? file;
  String kelas = "A";
  int? updateIdx;
  DateTime? date;

  List<String> languageOptions = ["Indonesian", "English", "Chinese", "Japanese"];
  List<String> kelasOptions = ['A', "B", "C", "D", "E"];

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (date != null) {
        Navigator.pop(context, {
          'person': Person(
            name: fullName!,
            phone: phoneNumber!,
            gender: option,
            languages: languages,
            file: file,
            kelas: kelas,
            date: date!,
          ),
          'idx': updateIdx,
        });
      }
    }
  }

  void handlePickFile() async {
    FilePickerResult? res = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (res != null) {
      File _file = File(res.files.single.path!);
      setState(() {
        file = _file;
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
        date = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (fullName == null && args != null) {
      if (args['person'] != null) {
        Person person = args['person'] as Person;
        setState(() {
          fullName = person.name;
          phoneNumber = person.phone;
          languages = person.languages;
          kelas = person.kelas;
          option = person.gender;
          file = person.file;
          updateIdx = args['idx'];
          date = person.date;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Create New Contact")),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                child: InkWell(
                  onTap: file == null ? handlePickFile : () => setState(() => file = null),
                  child: DottedBorder(
                    color: file == null ? Colors.blue : Colors.white,
                    dashPattern: const [10],
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: file == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("+", style: TextStyle(fontSize: 30, color: Colors.blue)),
                                  Text("Upload File", style: TextStyle(color: Colors.blue)),
                                ],
                              )
                            : Image.file(file!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: ((newValue) => fullName = newValue),
                initialValue: fullName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Full name'),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: ((newValue) => phoneNumber = newValue),
                keyboardType: TextInputType.phone,
                initialValue: phoneNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Phone number'),
              ),
              const SizedBox(height: 20),
              const Text("Tanggal Lahir"),
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: double.infinity,
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
                      date != null ? DateFormat('dd/MM/yyyy').format(date!) : 'dd/mm/yyyy',
                      style: TextStyle(color: date != null ? Colors.black : Colors.black45),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Laki - Laki'),
                    value: RadioOption.laki,
                    groupValue: option,
                    onChanged: (RadioOption? value) {
                      setState(() {
                        option = value ?? RadioOption.laki;
                      });
                    },
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Perempuan'),
                    value: RadioOption.perempuan,
                    groupValue: option,
                    onChanged: (RadioOption? value) {
                      setState(() {
                        option = value ?? RadioOption.perempuan;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Pilih bahasa Favourite mu",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                children: languageOptions
                    .map(
                      (e) => Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: languages.contains(e),
                            onChanged: (bool? value) {
                              setState(() {
                                if (languages.contains(e)) {
                                  languages.remove(e);
                                } else {
                                  languages.add(e);
                                }
                                // isChecked = value!;
                              });
                            },
                          ),
                          Text(e),
                        ],
                      ),
                    )
                    .toList(),
              ),
              Row(
                children: [
                  const Text("Kelas : "),
                  DropdownButton<String>(
                    value: kelas,
                    items: kelasOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => kelas = val);
                    },
                  ),
                ],
              ),
              Align(
                child: ElevatedButton(
                  onPressed: handleSubmit,
                  child: const Text("Submit"),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
