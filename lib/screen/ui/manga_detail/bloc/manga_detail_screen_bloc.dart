import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/model/bookmark/bookmark_model.dart';
import '../../../../core/model/history/history_model.dart';
import '../../../../core/model/manga_detail/manga_detail_model.dart';
import '../../../../core/repository/local/moor_repository.dart';
import '../../../../core/repository/remote/api_repository.dart';
import '../../../../core/util/connectivity_check.dart';
import '../../../../injection_container.dart';

part 'manga_detail_screen_event.dart';
part 'manga_detail_screen_state.dart';

class MangaDetailScreenBloc
    extends Bloc<MangaDetailScreenEvent, MangaDetailScreenState> {
  MangaDetailScreenBloc() : super(MangaDetailScreenInitial());

  // Variables
  final apiRepo = sl.get<APIRepository>();
  final dbRepo = sl.get<MoorDBRepository>();
  final connectivity = sl.get<ConnectivityCheck>();

  @override
  Stream<MangaDetailScreenState> mapEventToState(
    MangaDetailScreenEvent event,
  ) async* {
    yield MangaDetailScreenLoading();

    if (event is GetMangaDetailScreenData) {
      yield* getMangaDetailScreenDataToState(event);
    } else if (event is UpdateHistoryBottomNavbar) {
      yield* updateHistoryBottomNavbarToState(event);
    }
  }

  Stream<MangaDetailScreenState> updateHistoryBottomNavbarToState(
      UpdateHistoryBottomNavbar event) async* {
    try {
      yield MangaDetailScreenLoading();

      final historyResult = await dbRepo.getHistory(
          event.mangaDetail.title, event.mangaDetail.mangaEndpoint);

      yield MangaDetailScreenLoaded(
        mangaDetail: event.mangaDetail,
        isBookmarked: event.isBookmarked,
        bookmarkModel: event.bookmarkModel,
        historyModel: historyResult,
      );
    } on Exception {
      yield MangaDetailScreenError();
    }
  }

  Stream<MangaDetailScreenState> getMangaDetailScreenDataToState(
      GetMangaDetailScreenData event) async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield MangaDetailScreenError();

      final mangaDetail = await apiRepo.getMangaDetail(event.mangaEndpoint);
      final bookmarkResult =
          await dbRepo.getBookmark(event.title, event.mangaEndpoint);
      final historyResult =
          await dbRepo.getHistory(event.title, event.mangaEndpoint);

      yield MangaDetailScreenLoaded(
        mangaDetail: mangaDetail,
        isBookmarked: bookmarkResult != null ? true : false,
        bookmarkModel: bookmarkResult,
        historyModel: historyResult,
      );
    } on Exception {
      yield MangaDetailScreenError();
    }
  }
}
