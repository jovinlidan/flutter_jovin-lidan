part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class AddHistory extends HistoryEvent {
  HistoryCall history;

  AddHistory(this.history);
  @override
  List<Object?> get props => [history];
}
