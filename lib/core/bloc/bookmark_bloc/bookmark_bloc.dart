import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../model/bookmark/bookmark_model.dart';
import '../../provider/local/moor_db_provider.dart';
import '../../repository/local/moor_repository.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkInitial());
  final _moorDBRepository = MoorDBRepository();

  @override
  Stream<BookmarkState> mapEventToState(
    BookmarkEvent event,
  ) async* {
    if (event is InsertBookmark)
      yield* insertBookmarkToState(event);
    else if (event is UpdateBookmark)
      yield* updateBookmarkToState(event);
    else if (event is DeleteBookmark) yield* deleteBookmarkToState(event);
  }

  Stream<BookmarkState> insertBookmarkToState(InsertBookmark event) async* {
    try {
      final data = event.bookmarkModel;

      _moorDBRepository.insertBookmark(Bookmark(
          title: data.title,
          mangaEndpoint: data.mangaEndpoint,
          image: data.image,
          author: data.author,
          type: data.type,
          description: data.description,
          rating: data.rating,
          totalChapter: data.totalChapter,
          isNew: false));
    } catch (e) {
      yield BookmarkError(error: e.toString());
    }
  }

  Stream<BookmarkState> updateBookmarkToState(UpdateBookmark event) async* {
    try {
      final data = event.bookmarkModel;
      await _moorDBRepository.updateBookmark(Bookmark(
          title: data.title,
          mangaEndpoint: data.mangaEndpoint,
          image: data.image,
          author: data.author,
          type: data.type,
          description: data.description,
          rating: data.rating,
          totalChapter: data.totalChapter,
          isNew: false));
    } catch (e) {
      yield BookmarkError(error: e.toString());
    }
  }

  Stream<BookmarkState> deleteBookmarkToState(DeleteBookmark event) async* {
    try {
      final data = event.bookmarkModel;
      await _moorDBRepository.deleteBookmark(data.title, data.mangaEndpoint);
    } catch (e) {
      yield BookmarkError(error: e.toString());
    }
  }
}
