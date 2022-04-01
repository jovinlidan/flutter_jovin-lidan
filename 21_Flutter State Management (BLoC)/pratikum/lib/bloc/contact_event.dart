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
