part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  List<Person> data = [];

  ContactState(this.data);
  @override
  List<Object?> get props => [data];
}

class ContactInitial extends ContactState {
  ContactInitial()
      : super([
          Person(
              name: "Leane Graham",
              phone: "0812314362",
              gender: RadioOption.laki,
              languages: [],
              kelas: "A",
              date: DateTime.now()),
          Person(
              name: "Hwang ni",
              phone: "0812314362",
              gender: RadioOption.laki,
              languages: [],
              kelas: "B",
              date: DateTime.now()),
        ]);
  @override
  List<Object?> get props => [];
}

class AddContactState extends ContactState {
  final List<Person> newData;
  AddContactState(this.newData) : super(newData);
  @override
  List<Object?> get props => [data];
}

class UpdateContactState extends ContactState {
  final List<Person> newData;
  UpdateContactState(this.newData) : super(newData);
  @override
  List<Object?> get props => [data];
}

class DeleteContactState extends ContactState {
  final List<Person> newData;
  DeleteContactState(this.newData) : super(newData);
  @override
  List<Object?> get props => [data];
}
