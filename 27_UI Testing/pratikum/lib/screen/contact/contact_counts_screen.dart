import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratikum/repositories.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:provider/provider.dart';

class ContactCountsScreen extends StatefulWidget {
  const ContactCountsScreen({Key? key}) : super(key: key);

  @override
  State<ContactCountsScreen> createState() => _ContactCountsScreenState();
}

class _ContactCountsScreenState extends State<ContactCountsScreen> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ContactsViewModel>(context, listen: false).getAllContacts();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Counts")),
      body: Consumer<ContactsViewModel>(
        builder: (_, value, __) => value.contacts.status == ApiStatus.success
            ? Center(
                child: Text(
                  "${value.contacts.data?.length}",
                  style: const TextStyle(fontSize: 100),
                ),
              )
            : value.contacts.status == ApiStatus.loading
                ? const Center(
                    child: LoadingIndicator(indicatorType: Indicator.ballClipRotatePulse),
                  )
                : Center(child: Text("${value.contacts.message}")),
      ),
    );
  }
}
