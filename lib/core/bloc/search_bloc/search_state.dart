part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchMangaLoaded extends SearchState {
  final List<Manga> listManga;
  SearchMangaLoaded({@required this.listManga});

  @override
  List<Object> get props => [listManga];
}

class SearchBookmarkLoaded extends SearchState {
  final List<BookmarkModel> listBookmark;
  SearchBookmarkLoaded({@required this.listBookmark});

  @override
  List<Object> get props => [listBookmark];
}

class SearchHistoryLoaded extends SearchState {
  final List<HistoryModel> listHistory;
  SearchHistoryLoaded({@required this.listHistory});

  @override
  List<Object> get props => [listHistory];
}

class NoConnection extends SearchState {}
