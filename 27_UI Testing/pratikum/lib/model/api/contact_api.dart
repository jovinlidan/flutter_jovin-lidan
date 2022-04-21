import 'package:pratikum/model/contact_model.dart';
import 'package:pratikum/repositories.dart';

class ContactAPI {
  static Future<List<Contact>> getContacts() async {
    Repositories repo = Repositories();
    final response = await repo.get(url: 'contacts');
    return await Future.value(Contact.decode(response));
  }

  static Future<Contact> getContact({required int id}) async {
    Repositories repo = Repositories();
    final response = await repo.get(url: 'contacts/$id');
    return await Future.value(Contact.decodeOne(response));
  }

  static Future<Contact> postContact({required Contact contact}) async {
    Repositories repo = Repositories();
    final response =
        await repo.post<Map<String, dynamic>>(url: "contacts", data: Contact.encodeOne(contact));
    return await Future.value(Contact.decodeOne(response));
  }
}
