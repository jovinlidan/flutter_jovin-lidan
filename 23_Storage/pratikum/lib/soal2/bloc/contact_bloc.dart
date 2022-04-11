import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pratikum/model.dart';
import 'package:pratikum/repositories.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  late Repositories repo;
  ContactBloc() : super(ContactInitial()) {
    repo = Repositories(repoKey: "personsBloc");
    on<InitContact>(
      (event, emit) async {
        emit(ContactLoading());
        String? personStr = await repo.getData();
        if (personStr != null) {
          return emit(AddContactState(Person.decode(personStr)));
        }
        emit(ContactInitial());
      },
    );

    on<AddContact>((event, emit) {
      List<Person> temp = [...state.data, event.person];

      repo.setData(Person.encode(temp));
      emit(AddContactState(temp));
    });

    on<UpdateContact>((event, emit) {
      List<Person> temp = [...state.data];
      temp[event.idx] = event.person;
      repo.setData(Person.encode(temp));
      emit(UpdateContactState(temp));
    });

    on<DeleteContact>(((event, emit) {
      List<Person> temp = [...state.data];
      temp.removeAt(event.idx);
      repo.setData(Person.encode(temp));
      emit(DeleteContactState(temp));
    }));
  }
}
