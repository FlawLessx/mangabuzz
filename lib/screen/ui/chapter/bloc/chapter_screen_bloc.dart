import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangabuzz/core/model/chapter/chapter_model.dart';
import 'package:mangabuzz/core/model/manga_detail/manga_detail_model.dart';
import 'package:mangabuzz/core/repository/remote/api_repository.dart';
import 'package:mangabuzz/core/util/connectivity_check.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'chapter_screen_event.dart';
part 'chapter_screen_state.dart';

class ChapterScreenBloc extends Bloc<ChapterScreenEvent, ChapterScreenState> {
  ChapterScreenBloc() : super(ChapterScreenInitial());

  // Variables
  final apiRepo = APIRepository();
  final connectivity = ConnectivityCheck();

  @override
  Stream<ChapterScreenState> mapEventToState(
    ChapterScreenEvent event,
  ) async* {
    yield ChapterScreenLoading();
    if (state is InitialStateChapterScreen)
      yield ChapterScreenInitial();
    else if (event is GetChapterScreenData)
      yield* getChapterScreenDataToState(event);
  }

  Stream<ChapterScreenState> getChapterScreenDataToState(
      GetChapterScreenData event) async* {
    try {
      bool status = await connectivity.checkConnectivity();
      if (status == false) yield ChapterScreenError();

      final data = await apiRepo.getChapter(event.chapterEndpoint);

      var mangaDetail;
      if (event.mangaDetail != null)
        mangaDetail = event.mangaDetail;
      else
        mangaDetail = await apiRepo.getMangaDetail(event.mangaEndpoint);

      yield ChapterScreenLoaded(
          selectedIndex: event.selectedIndex,
          mangaDetail: mangaDetail,
          chapterList: mangaDetail.chapterList,
          chapterImg: data);
    } on Exception {
      yield ChapterScreenError();
    }
  }
}
