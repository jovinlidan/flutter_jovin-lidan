import 'dart:convert';
import 'dart:io';

enum RadioOption { laki, perempuan }

class Person {
  String name;
  String phone;
  dynamic file;
  RadioOption gender;
  List<String> languages;
  String kelas;
  DateTime date;

  Person(
      {required this.name,
      required this.phone,
      this.file,
      required this.gender,
      required this.languages,
      required this.kelas,
      required this.date});

  factory Person.fromJson(Map<String, dynamic> jsonData) {
    return Person(
      name: jsonData['name'],
      phone: jsonData['phone'],
      file:
          jsonData['file'] is String ? File.fromUri(Uri.parse(jsonData['file'])) : jsonData['file'],
      gender: RadioOption.values[jsonData['gender']],
      languages: List.from(jsonData['languages']),
      kelas: jsonData['kelas'],
      date: DateTime.parse(jsonData['date']),
    );
  }

  static Map<String, dynamic> toMap(Person person) => {
        'name': person.name,
        'phone': person.phone,
        'file': person.file?.uri.toString(),
        'gender': person.gender.index,
        'languages': person.languages,
        'kelas': person.kelas,
        'date': person.date.toString(),
      };

  static String encode(List<Person> persons) => json.encode(
        persons.map<Map<String, dynamic>>((person) => Person.toMap(person)).toList(),
      );
  static String encodeOne(Person person) => json.encode(Person.toMap(person));

  static List<Person> decode(String persons) =>
      (json.decode(persons) as List<dynamic>).map<Person>((item) => Person.fromJson(item)).toList();

  static Person decodeOne(String person) => Person.fromJson(json.decode(person) as dynamic);
}

class HistoryCall extends Person {
  Person person;
  DateTime timestamp;
  HistoryCall({required this.person, required this.timestamp})
      : super(
            date: person.date,
            gender: person.gender,
            kelas: person.kelas,
            languages: person.languages,
            name: person.name,
            phone: person.phone,
            file: person.file);

  factory HistoryCall.fromJson(Map<String, dynamic> jsonData) {
    return HistoryCall(
      person: Person.decodeOne(jsonData['person']),
      timestamp: DateTime.parse(jsonData['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(HistoryCall history) => {
        'person': Person.encodeOne(history.person),
        'timestamp': history.timestamp.toString(),
      };

  static String encode(List<HistoryCall> histories) => json.encode(
        histories.map<Map<String, dynamic>>((history) => HistoryCall.toMap(history)).toList(),
      );

  static List<HistoryCall> decode(String histories) => (json.decode(histories) as List<dynamic>)
      .map<HistoryCall>((item) => HistoryCall.fromJson(item))
      .toList();
}
