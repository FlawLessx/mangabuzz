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
  final bool hasReachedMax;
  HistoryScreenLoaded(
      {@required this.listHistoryData, @required this.hasReachedMax});

  HistoryScreenLoaded copyWith(
      {List<HistoryModel> listBookmarkData, bool hasReachedMax}) {
    return HistoryScreenLoaded(
        listHistoryData: listBookmarkData ?? this.listHistoryData,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [listHistoryData, hasReachedMax];
}

class HistoryScreenError extends HistoryScreenState {}
