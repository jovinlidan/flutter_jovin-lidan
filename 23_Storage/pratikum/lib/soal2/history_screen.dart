import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pratikum/model.dart';
import 'package:pratikum/soal2/bloc/history_bloc.dart';

class HistoryScreen extends StatelessWidget {
  static const historyScreenName = "/history";

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History Calls")),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) => ListView.builder(
          itemBuilder: (context, index) => CustomCard(history: state.data[index]),
          itemCount: state.data.length,
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final HistoryCall history;
  const CustomCard({Key? key, required this.history}) : super(key: key);

  void handleOpenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Contact Details"),
        content: Container(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [const Expanded(child: Text("Name")), Text(history.name)]),
              const SizedBox(height: 20),
              Row(children: [const Expanded(child: Text("Phone")), Text(history.phone)]),
              const SizedBox(height: 20),
              Row(children: [const Expanded(child: Text("Gender")), Text(history.gender.name)]),
              const SizedBox(height: 20),
              Row(children: [const Expanded(child: Text("Kelas")), Text(history.kelas)]),
              const SizedBox(height: 20),
              Row(children: [
                const Expanded(child: Text("Tanggal Lahir")),
                Text(DateFormat('dd/MM/yyyy').format(history.date))
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Text("Languages")),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: history.languages.isNotEmpty
                        ? history.languages.map((e) => Text(e)).toList()
                        : [const Text('-')],
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        leading: CircleAvatar(
          backgroundImage: history.file != null ? FileImage(history.file!) : null,
          child: history.file == null
              ? Text(
                  history.name.characters.first,
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                )
              : null,
          radius: 26,
          backgroundColor: Colors.green,
        ),
        title: Text(history.name, style: const TextStyle(fontSize: 20)),
        subtitle: Text(history.phone, style: const TextStyle(fontSize: 16)),
        onTap: () => handleOpenDialog(context),
        trailing: Text(DateFormat("dd-MM-yyyy HH:mm:ss").format(history.timestamp)));
  }
}
