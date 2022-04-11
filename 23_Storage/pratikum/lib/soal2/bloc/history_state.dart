part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {
  List<HistoryCall> data = [];

  HistoryState({List<HistoryCall>? data}) {
    if (data != null) {
      this.data = data;
    }
  }
  @override
  List<Object?> get props => [data];
}

class HistoryLoading extends HistoryState {}

class HistoryInitial extends HistoryState {
  HistoryInitial() : super(data: []);
  @override
  List<Object?> get props => [];
}

class AddHistoryState extends HistoryState {
  final List<HistoryCall> newData;
  AddHistoryState(this.newData) : super(data: newData);
  @override
  List<Object?> get props => [data];
}
