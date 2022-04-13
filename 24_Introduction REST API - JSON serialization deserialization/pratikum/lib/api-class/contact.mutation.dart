import 'package:pratikum/api-class/contact.model.dart';
import 'package:pratikum/repositories.dart';

class PostContact {
  late Repositories repo;
  PostContact() {
    repo = Repositories();
  }
  Future<dynamic>? post({required Contact contact}) async {
    return await repo.post<Map<String, dynamic>>(url: "contacts", data: Contact.encodeOne(contact));
  }
}
