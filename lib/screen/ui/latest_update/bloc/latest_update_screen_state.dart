part of 'latest_update_screen_bloc.dart';

abstract class LatestUpdateScreenState extends Equatable {
  const LatestUpdateScreenState();

  @override
  List<Object> get props => [];
}

class LatestUpdateScreenInitial extends LatestUpdateScreenState {}

class LatestUpdateScreenLoading extends LatestUpdateScreenState {}

class LatestUpdateScreenLoaded extends LatestUpdateScreenState {
  final LatestUpdate latestUpdate;

  LatestUpdateScreenLoaded({@required this.latestUpdate});

  @override
  List<Object> get props => [latestUpdate];
}

class LatestUpdateScreenError extends LatestUpdateScreenState {}
