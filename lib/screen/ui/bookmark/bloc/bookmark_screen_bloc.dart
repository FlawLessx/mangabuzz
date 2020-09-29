import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mangabuzz/core/model/bookmark/bookmark_model.dart';
import 'package:mangabuzz/core/provider/local/moor_db_provider.dart';
import 'package:mangabuzz/core/repository/local/moor_repository.dart';
import 'package:mangabuzz/core/repository/remote/api_repository.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'bookmark_screen_event.dart';
part 'bookmark_screen_state.dart';

class BookmarkScreenBloc
    extends Bloc<BookmarkScreenEvent, BookmarkScreenState> {
  BookmarkScreenBloc() : super(BookmarkScreenInitial());

  // Variables
  final apiRepo = APIRepository();
  final dbRepo = MoorDBRepository();

  @override
  Stream<BookmarkScreenState> mapEventToState(
    BookmarkScreenEvent event,
  ) async* {
    yield BookmarkScreenLoading();

    if (event is GetBookmarkScreenData) yield* getBookmarkDataToState(event);
  }

  Stream<BookmarkScreenState> getBookmarkDataToState(
      GetBookmarkScreenData event) async* {
    final data =
        await dbRepo.listAllBookmark(event.limit, offset: event.offset);
    List<BookmarkModel> result = [];

    // Get new release from api
    for (var item in data) {
      var dataFromAPI = await apiRepo.getMangaDetail(item.mangaEndpoint);

      if (dataFromAPI.chapterList.length != item.totalChapter) {
        item.isNew = true;
        item.totalChapter = dataFromAPI.chapterList.length;

        await dbRepo.updateBookmark(BookmarksCompanion(
            title: Value(item.title),
            author: Value(item.author),
            description: Value(item.description),
            image: Value(item.image),
            mangaEndpoint: Value(item.mangaEndpoint),
            rating: Value(item.rating),
            type: Value(item.type),
            totalChapter: Value(item.totalChapter),
            isNew: Value(false)));
      } else {
        item.isNew = false;
      }

      result.add(item);
    }

    yield BookmarkScreenLoaded(listBookmarkData: result);
  }
}
