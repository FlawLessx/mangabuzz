part of 'history_screen_bloc.dart';

abstract class HistoryScreenState extends Equatable {
  const HistoryScreenState();

  @override
  List<Object> get props => [];
}

class HistoryScreenInitial extends HistoryScreenState {}

class HistoryScreenLoading extends HistoryScreenState {}

class HistoryScreenLoaded extends HistoryScreenState {
  final List<HistoryModel> listHistoryData;
  HistoryScreenLoaded({@required this.listHistoryData});

  @override
  List<Object> get props => [];
}

class HistoryScreenError extends HistoryScreenState {}
