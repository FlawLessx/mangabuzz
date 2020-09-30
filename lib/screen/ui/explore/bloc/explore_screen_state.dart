part of 'explore_screen_bloc.dart';

abstract class ExploreScreenState extends Equatable {
  const ExploreScreenState();

  @override
  List<Object> get props => [];
}

class ExploreScreenInitial extends ExploreScreenState {}

class ExploreScreenLoading extends ExploreScreenState {}

class ExploreScreenLoaded extends ExploreScreenState {
  final List<Genre> listGenre;
  final List<Manga> listManga;
  final List<Manga> listManhwa;
  final List<Manga> listManhua;

  ExploreScreenLoaded(
      {@required this.listGenre,
      @required this.listManga,
      @required this.listManhwa,
      @required this.listManhua});

  @override
  List<Object> get props => [listGenre, listManga, listManhwa, listManhua];
}

class ExploreScreenError extends ExploreScreenState {}
