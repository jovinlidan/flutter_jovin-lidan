import 'package:pratikum/api-class/contact.model.dart';
import 'package:pratikum/repositories.dart';

class GetContacts {
  late Repositories _repo;

  GetContacts() {
    _repo = Repositories();
  }
  Future<List<Contact>> get() async {
    List<dynamic> res = await _repo.get(url: "contacts");
    return await Future.value(Contact.decode(res));
  }
}

class GetContact {
  late Repositories _repo;
  late int id;

  GetContact({required this.id}) {
    _repo = Repositories();
  }
  Future<Contact> get() async {
    dynamic res = await _repo.get(url: "contacts/$id");
    return await Future.value(Contact.decodeOne(res));
  }
}
