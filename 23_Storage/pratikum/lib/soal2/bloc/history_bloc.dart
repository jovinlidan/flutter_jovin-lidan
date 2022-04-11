import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pratikum/model.dart';
import 'package:pratikum/repositories.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  late Repositories repo;

  HistoryBloc() : super(HistoryInitial()) {
    repo = Repositories(repoKey: "historiesBloc");

    on<InitHistory>(
      (event, emit) async {
        emit(HistoryLoading());
        String? historiesStr = await repo.getData();
        if (historiesStr != null) {
          return emit(AddHistoryState(HistoryCall.decode(historiesStr)));
        }
        emit(HistoryInitial());
      },
    );
    on<AddHistory>((event, emit) {
      List<HistoryCall> temp = [event.history, ...state.data];
      repo.setData(HistoryCall.encode(temp));
      emit(AddHistoryState(temp));
    });
  }
}
