import 'dart:convert';

class Contact {
  int id;
  String name;
  String phone;

  Contact({required this.id, required this.name, required this.phone});

  factory Contact.fromJson(Map<String, dynamic> jsonData) {
    return Contact(
      id: jsonData['id'],
      name: jsonData['name'],
      phone: jsonData['phone'],
    );
  }

  static Map<String, dynamic> toMap(Contact person) => {
        'id': person.id,
        'name': person.name,
        'phone': person.phone,
      };

  static String encode(List<Contact> persons) => json.encode(
        persons.map<Map<String, dynamic>>((person) => Contact.toMap(person)).toList(),
      );
  static Map<String, dynamic> encodeOne(Contact person) => Contact.toMap(person);

  static List<Contact> decode(List<dynamic> data) =>
      (data.map<Contact>((item) => Contact.fromJson(item)).toList());

  static Contact decodeOne(dynamic person) => Contact.fromJson(person);
}
