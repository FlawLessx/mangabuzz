part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class ResetSearchBlocToInitialState extends SearchEvent {}

class SearchManga extends SearchEvent {
  final String query;
  SearchManga({@required this.query});

  @override
  List<Object> get props => [query];
}

class SearchBookmark extends SearchEvent {
  final String query;
  SearchBookmark({@required this.query});

  @override
  List<Object> get props => [query];
}

class SearchHistory extends SearchEvent {
  final String query;
  SearchHistory({@required this.query});

  @override
  List<Object> get props => [query];
}
