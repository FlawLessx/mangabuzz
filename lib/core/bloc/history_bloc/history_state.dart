part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistorySuccess extends HistoryState {
  final HistoryModel historyModel;
  HistorySuccess({this.historyModel});

  @override
  List<Object> get props => [historyModel];
}

class HistoryError extends HistoryState {
  final String error;
  HistoryError({@required this.error});

  @override
  List<Object> get props => [error];
}
