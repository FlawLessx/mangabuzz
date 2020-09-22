part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistorySuccess extends HistoryState {}

class HistoryError extends HistoryState {
  final String error;
  HistoryError({@required this.error});

  @override
  List<Object> get props => [error];
}
