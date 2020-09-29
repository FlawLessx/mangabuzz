part of 'history_screen_bloc.dart';

abstract class HistoryScreenEvent extends Equatable {
  const HistoryScreenEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryScreenData extends HistoryScreenEvent {
  final int limit;
  final int offset;

  GetHistoryScreenData({@required this.limit, this.offset});
}
