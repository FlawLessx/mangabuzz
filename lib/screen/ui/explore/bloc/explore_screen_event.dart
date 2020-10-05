part of 'explore_screen_bloc.dart';

abstract class ExploreScreenEvent extends Equatable {
  const ExploreScreenEvent();

  @override
  List<Object> get props => [];
}

class GetExploreScreenData extends ExploreScreenEvent {}
