import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../../../core/model/chapter/chapter_model.dart';
import '../../../../core/model/history/history_model.dart';
import '../../../../core/model/manga_detail/manga_detail_model.dart';
import '../../../../core/repository/remote/api_repository.dart';
import '../../../../core/util/connectivity_check.dart';
import '../../../../injection_container.dart';

part 'chapter_screen_event.dart';
part 'chapter_screen_state.dart';

class ChapterScreenBloc extends Bloc<ChapterScreenEvent, ChapterScreenState> {
  ChapterScreenBloc() : super(ChapterScreenInitial());

  // Variables
  final apiRepo = sl.get<APIRepository>();
  final connectivity = sl.get<ConnectivityCheck>();

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
          chapterImg: data,
          fromHome: event.fromHome);
    } on Exception {
      yield ChapterScreenError();
    }
  }
}
