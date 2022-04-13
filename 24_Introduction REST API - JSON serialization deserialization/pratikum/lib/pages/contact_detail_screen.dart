import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratikum/api-class/contact.model.dart';
import 'package:pratikum/api-class/contact.query.dart';

class ContactDetailScreen extends StatefulWidget {
  late int id;
  ContactDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  late GetContact getContact;
  bool isLoading = false;
  Contact? contact;
  @override
  void initState() {
    contactInit();
    super.initState();
  }

  void contactInit() async {
    try {
      setState(() => isLoading = true);
      isLoading = true;
      getContact = GetContact(id: widget.id);
      Contact newContact = await getContact.get();
      setState(() {
        contact = newContact;
      });
    } catch (e) {
      if (e is DioError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${contact?.id}")),
      body: SizedBox(
        width: double.infinity,
        child: isLoading
            ? const Center(
                child: LoadingIndicator(indicatorType: Indicator.ballClipRotatePulse),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    child: Text(
                      "${contact?.name.characters.first}",
                      style: const TextStyle(fontSize: 50, color: Colors.white),
                    ),
                    radius: 50,
                    backgroundColor: Colors.green,
                  ),
                  const SizedBox(height: 40),
                  Text("${contact?.name}", style: const TextStyle(fontSize: 40)),
                  const SizedBox(height: 20),
                  Text("${contact?.phone}", style: const TextStyle(fontSize: 30)),
                ],
              ),
      ),
    );
  }
}
