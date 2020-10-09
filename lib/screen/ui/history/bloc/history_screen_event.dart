part of 'history_screen_bloc.dart';

abstract class HistoryScreenEvent extends Equatable {
  const HistoryScreenEvent();

  @override
  List<Object> get props => [];
}

class ResetToInitialState extends HistoryScreenEvent {}

class GetHistoryScreenData extends HistoryScreenEvent {}
