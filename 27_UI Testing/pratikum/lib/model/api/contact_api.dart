import 'package:pratikum/model/contact_model.dart';
import 'package:pratikum/repositories.dart';

class ContactAPI {
  static Future<List<Contact>> getContacts() async {
    Repositories repo = Repositories();
    // final response = await repo.get(url: 'contacts');
    // return await Future.value(Contact.decode(response));
    final response = [Contact(id: 1, name: "Jovin", phone: "0895414368368")];
    return await Future.value(response);
  }

  static Future<Contact> getContact({required int id}) async {
    Repositories repo = Repositories();
    // final response = await repo.get(url: 'contacts/$id');
    // return await Future.value(Contact.decodeOne(response));
    final response = Contact(id: 1, name: "Jovin", phone: "0895414368368");
    return Future.value(response);
  }

  static Future<Contact> postContact({required Contact contact}) async {
    Repositories repo = Repositories();
    final response =
        await repo.post<Map<String, dynamic>>(url: "contacts", data: Contact.encodeOne(contact));
    return await Future.value(Contact.decodeOne(response));
  }
}
