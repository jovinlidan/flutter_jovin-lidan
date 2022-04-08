import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pratikum/model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    // on<HistoryEvent>((event, emit) {

    // });
    on<AddHistory>((event, emit) {
      List<HistoryCall> temp = [event.history];
      emit(AddHistoryState([
        ...temp,
        ...state.data,
      ]));
    });
  }
}
