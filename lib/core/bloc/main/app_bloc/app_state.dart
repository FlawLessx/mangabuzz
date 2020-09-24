part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppDataLoading extends AppState {}

class AppDataLoaded extends AppState {
  final List<BestSeries> listBestSeries;
  final List<Manga> listHotMangaUpdate;
  final LatestUpdate listLatestUpdate;
  final List<BookmarkModel> listBookmark;
  final List<HistoryModel> listHistory;

  AppDataLoaded(
      {@required this.listBestSeries,
      @required this.listHotMangaUpdate,
      @required this.listLatestUpdate,
      @required this.listBookmark,
      @required this.listHistory});

  @override
  List<Object> get props => [
        listBestSeries,
        listHotMangaUpdate,
        listLatestUpdate,
        listBookmark,
        listHistory
      ];
}

class NoConnection extends AppState {}
