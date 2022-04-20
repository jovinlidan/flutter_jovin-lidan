import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratikum/repositories.dart';
import 'package:pratikum/screen/contact/contact_detail_view_model.dart';
import 'package:provider/provider.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({Key? key}) : super(key: key);

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final id = ModalRoute.of(context)!.settings.arguments as int?;
      Provider.of<ContactDetailViewModel>(context, listen: false).getContact(id: id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactDetailViewModel>(
      builder: (_, value, __) => Scaffold(
        appBar: AppBar(title: Text("${value.contact?.data?.id}")),
        body: SizedBox(
          width: double.infinity,
          child: value.contact?.status == ApiStatus.loading
              ? const Center(
                  child: LoadingIndicator(indicatorType: Indicator.ballClipRotatePulse),
                )
              : value.contact?.status == ApiStatus.error
                  ? Center(child: Text("${value.contact?.message}"))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        CircleAvatar(
                          child: Text(
                            "${value.contact?.data?.name.characters.first}",
                            style: const TextStyle(fontSize: 50, color: Colors.white),
                          ),
                          radius: 50,
                          backgroundColor: Colors.green,
                        ),
                        const SizedBox(height: 40),
                        Text("${value.contact?.data?.name}", style: const TextStyle(fontSize: 40)),
                        const SizedBox(height: 20),
                        Text("${value.contact?.data?.phone}", style: const TextStyle(fontSize: 30)),
                      ],
                    ),
        ),
      ),
    );
  }
}
