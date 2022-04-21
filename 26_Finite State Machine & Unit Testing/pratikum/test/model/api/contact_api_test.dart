import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pratikum/model/api/contact_api.dart';
import 'package:pratikum/model/contact_model.dart';
import 'package:pratikum/repositories.dart';
import 'package:pratikum/screen/contact/contacts_view_model.dart';
import 'package:test/test.dart';

import 'contact_api_test.mocks.dart';

@GenerateMocks([ContactAPI])
void main() {
  group('Contact API', () {
    MockContactAPI contactAPI = MockContactAPI();
    test('get all contacts returns state', () async {
      var contactViewModel = ContactsViewModel();
      expect(contactViewModel.contacts.status, ApiStatus.success);

      contactViewModel.getAllContacts();
      expect(contactViewModel.contacts.status, ApiStatus.loading);

      await contactViewModel.getAllContacts();

      expect(contactViewModel.contacts.status, ApiStatus.success);
    });
    test('get all contacts returns data', () async {
      when(contactAPI.getContacts())
          .thenAnswer((_) async => <Contact>[Contact(id: 1, name: 'a', phone: '1')]);
      var contacts = await contactAPI.getContacts();
      expect(contacts.isNotEmpty, true);
    });
  });
}
