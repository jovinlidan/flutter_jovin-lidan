import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pratikum/soal1soal2.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    // on<ContactEvent>((event, emit) => emit(ContactInitial()));

    // kalau panggil add contact otomatis contact event ke trigger
    on<AddContact>((event, emit) {
      List<Person> temp = [event.person];
      emit(AddContactState([
        ...state.data,
        ...temp,
      ]));
    });
  }
}
