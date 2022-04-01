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
          Person(name: "Leane Graham", phone: "0812314362"),
          Person(name: "Hwang ni", phone: "0812314362"),
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
