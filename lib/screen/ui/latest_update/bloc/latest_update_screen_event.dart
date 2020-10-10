part of 'latest_update_screen_bloc.dart';

abstract class LatestUpdateScreenEvent extends Equatable {
  const LatestUpdateScreenEvent();

  @override
  List<Object> get props => [];
}

class GetLatestUpdateScreenData extends LatestUpdateScreenEvent {
  final int pageNumber;

  GetLatestUpdateScreenData({@required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}
