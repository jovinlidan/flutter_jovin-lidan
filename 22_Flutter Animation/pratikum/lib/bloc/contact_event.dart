part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}

class AddContact extends ContactEvent {
  Person person;

  AddContact(this.person);
  @override
  List<Object?> get props => [person];
}

class UpdateContact extends ContactEvent {
  int idx;
  Person person;

  UpdateContact(this.person, this.idx);
  @override
  List<Object?> get props => [person, idx];
}

class DeleteContact extends ContactEvent {
  int idx;
  DeleteContact(this.idx);
  @override
  List<Object?> get props => [idx];
}
