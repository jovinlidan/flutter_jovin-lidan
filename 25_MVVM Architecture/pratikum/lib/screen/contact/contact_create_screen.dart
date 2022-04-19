import 'package:flutter/material.dart';
import 'package:pratikum/model/contact_model.dart';
import 'package:pratikum/repositories.dart';
import 'package:pratikum/screen/contact/contact_create_view_model.dart';
import 'package:provider/provider.dart';

class ContactCreateScreen extends StatefulWidget {
  const ContactCreateScreen({Key? key}) : super(key: key);

  @override
  State<ContactCreateScreen> createState() => _ContactCreateScreenState();
}

class _ContactCreateScreenState extends State<ContactCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  String? fullName;

  String? phoneNumber;

  void handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await Provider.of<ContactCreateViewModel>(context, listen: false)
          .postContact(contact: Contact(id: 4, name: fullName!, phone: phoneNumber!));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Contact")),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: ((newValue) => fullName = newValue),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Phone number'),
            ),
            Consumer<ContactCreateViewModel>(
              builder: (_, value, __) => ElevatedButton(
                onPressed: value.contacts?.status == ApiStatus.success
                    ? () => handleSubmit(context)
                    : null,
                child: value.contacts?.status == ApiStatus.loading
                    ? const Text("Loading...")
                    : const Text("Submit"),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
