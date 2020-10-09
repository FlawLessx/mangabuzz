part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class AddHistory extends HistoryEvent {
  final HistoryModel historyModel;
  AddHistory({@required this.historyModel});

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
  final String title;
  final String mangaEndpoint;
  DeleteHistory({@required this.title, @required this.mangaEndpoint});

  @override
  List<Object> get props => [title, mangaEndpoint];
}
