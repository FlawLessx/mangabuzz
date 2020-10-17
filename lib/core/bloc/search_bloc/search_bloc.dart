import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../../injection_container.dart';
import '../../model/bookmark/bookmark_model.dart';
import '../../model/history/history_model.dart';
import '../../model/manga/manga_model.dart';
import '../../repository/local/moor_repository.dart';
import '../../repository/remote/api_repository.dart';
import '../../util/connectivity_check.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  final _apiRepository = sl.get<APIRepository>();
  final _moorRepository = sl.get<MoorDBRepository>();
  final _connectivityCheck = sl.get<ConnectivityCheck>();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    yield SearchLoading();

    if (event is SearchManga)
      yield* _searchMangaToState(event);
    else if (event is SearchBookmark)
      yield* _searchBookmarkToState(event);
    else if (event is SearchHistory)
      yield* _searchHistoryToState(event);
    else if (event is ResetSearchBlocToInitialState) yield SearchInitial();
  }

  Stream<SearchState> _searchMangaToState(SearchManga event) async* {
    try {
      bool isConnedted = await _connectivityCheck.checkConnectivity();
      if (isConnedted == false) yield NoConnection();

      final List<Manga> listManga = await _apiRepository.getSearch(event.query);
      yield SearchMangaLoaded(listManga: listManga);
    } on Exception {
      yield NoConnection();
    }
  }

  Stream<SearchState> _searchBookmarkToState(SearchBookmark event) async* {
    try {
      bool isConnedted = await _connectivityCheck.checkConnectivity();
      if (isConnedted == false) yield NoConnection();

      final List<BookmarkModel> listBookmark =
          await _moorRepository.searchBookmarkByQuery(event.query);
      yield SearchBookmarkLoaded(listBookmark: listBookmark);
    } on Exception {
      yield NoConnection();
    }
  }

  Stream<SearchState> _searchHistoryToState(SearchHistory event) async* {
    try {
      bool isConnedted = await _connectivityCheck.checkConnectivity();
      if (isConnedted == false) yield NoConnection();

      final List<HistoryModel> listHistory =
          await _moorRepository.searchHistoryByQuery(event.query);
      yield SearchHistoryLoaded(listHistory: listHistory);
    } on Exception {
      yield NoConnection();
    }
  }
}
