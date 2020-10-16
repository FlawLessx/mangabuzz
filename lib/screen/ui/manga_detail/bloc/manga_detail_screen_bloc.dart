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

part 'manga_detail_screen_event.dart';
part 'manga_detail_screen_state.dart';

class MangaDetailScreenBloc
    extends Bloc<MangaDetailScreenEvent, MangaDetailScreenState> {
  MangaDetailScreenBloc() : super(MangaDetailScreenInitial());

  // Variables
  final apiRepo = APIRepository();
  final dbRepo = MoorDBRepository();
  final connectivity = ConnectivityCheck();

  @override
  Stream<MangaDetailScreenState> mapEventToState(
    MangaDetailScreenEvent event,
  ) async* {
    yield MangaDetailScreenLoading();

    if (event is GetMangaDetailScreenData)
      yield* getMangaDetailScreenDataToState(event);
  }

  Stream<MangaDetailScreenState> getMangaDetailScreenDataToState(
      GetMangaDetailScreenData event) async* {
    try {
      var historyResult;
      var bookmarkResult;

      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield MangaDetailScreenError();

      final dataManga = await apiRepo.getMangaDetail(event.mangaEndpoint);

      bookmarkResult =
          await dbRepo.getBookmark(event.title, event.mangaEndpoint);

      historyResult = await dbRepo.getHistory(event.title, event.mangaEndpoint);

      yield MangaDetailScreenLoaded(
          mangaDetail: dataManga,
          isBookmarked: bookmarkResult != null ? true : false,
          bookmarkModel: bookmarkResult,
          historyModel: historyResult);
    } on Exception {
      yield MangaDetailScreenError();
    }
  }
}
