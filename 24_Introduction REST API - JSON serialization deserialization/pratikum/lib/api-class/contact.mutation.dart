import 'package:pratikum/repositories.dart';

class PostContact {
  late Repositories repo;
  PostContact() {
    repo = Repositories();
  }
  // void post({required Person}) async {
  //   return repo.get<Map<String, dynamic>>(
  //       url: "https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts");
  // }
}
