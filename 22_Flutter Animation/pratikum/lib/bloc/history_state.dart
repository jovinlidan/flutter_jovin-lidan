part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {
  List<HistoryCall> data = [];

  HistoryState(this.data);
  @override
  List<Object?> get props => [data];
}

class HistoryInitial extends HistoryState {
  HistoryInitial() : super([]);
  @override
  List<Object?> get props => [];
}

class AddHistoryState extends HistoryState {
  final List<HistoryCall> newData;
  AddHistoryState(this.newData) : super(newData);
  @override
  List<Object?> get props => [data];
}
