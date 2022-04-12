import 'package:pratikum/api-class/contact.model.dart';
import 'package:pratikum/repositories.dart';

class GetContacts {
  late Repositories _repo;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  GetContacts() {
    _repo = Repositories();
  }
  Future<List<Contact>> get() async {
    _isLoading = true;
    List<dynamic> res = await _repo.get(
        url: "https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts");
    _isLoading = false;
    return await Future.value(Contact.decode(res));
  }
}
