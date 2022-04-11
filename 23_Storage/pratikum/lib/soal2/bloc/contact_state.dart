part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  List<Person> data = [];

  ContactState({List<Person>? val}) {
    if (val != null) {
      data = val;
    }
  }
  @override
  List<Object?> get props => [data];
}

class ContactLoading extends ContactState {}

class ContactInitial extends ContactState {
  ContactInitial() : super();
  @override
  List<Object?> get props => [];
}

class AddContactState extends ContactState {
  final List<Person> newData;
  AddContactState(this.newData) : super(val: newData);
  @override
  List<Object?> get props => [data];
}

class UpdateContactState extends ContactState {
  final List<Person> newData;
  UpdateContactState(this.newData) : super(val: newData);
  @override
  List<Object?> get props => [data];
}

class DeleteContactState extends ContactState {
  final List<Person> newData;
  DeleteContactState(this.newData) : super(val: newData);
  @override
  List<Object?> get props => [data];
}
