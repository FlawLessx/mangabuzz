part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class InsertHistory extends HistoryEvent {
  final HistoryModel historyModel;
  InsertHistory({@required this.historyModel});

  @override
  List<Object> get props => [historyModel];
}

class UpdateHistory extends HistoryEvent {
  final HistoryModel historyModel;
  UpdateHistory({@required this.historyModel});

  @override
  List<Object> get props => [historyModel];
}

class DeleteHistory extends HistoryEvent {
  final HistoryModel historyModel;
  DeleteHistory({@required this.historyModel});

  @override
  List<Object> get props => [historyModel];
}
