part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<BestSeries> listBestSeries;
  final List<Manga> listHotMangaUpdate;
  final LatestUpdate listLatestUpdate;
  HomeScreenLoaded(
      {@required this.listBestSeries,
      @required this.listHotMangaUpdate,
      @required this.listLatestUpdate});

  @override
  List<Object> get props =>
      [listBestSeries, listHotMangaUpdate, listLatestUpdate];
}

class HomeScreenError extends HomeScreenState {}
