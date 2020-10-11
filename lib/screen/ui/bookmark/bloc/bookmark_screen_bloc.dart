import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mangabuzz/core/model/bookmark/bookmark_model.dart';
import 'package:mangabuzz/core/repository/local/moor_repository.dart';
import 'package:mangabuzz/core/repository/remote/api_repository.dart';
import 'package:mangabuzz/core/util/connectivity_check.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'bookmark_screen_event.dart';
part 'bookmark_screen_state.dart';

class BookmarkScreenBloc
    extends Bloc<BookmarkScreenEvent, BookmarkScreenState> {
  BookmarkScreenBloc() : super(BookmarkScreenInitial());

  // Variables
  final apiRepo = APIRepository();
  final dbRepo = MoorDBRepository();
  final connectivity = ConnectivityCheck();
  List<BookmarkModel> listBookmarkModel = [];

  @override
  Stream<BookmarkScreenState> mapEventToState(
    BookmarkScreenEvent event,
  ) async* {
    if (event is ResetBookmarkScreenBlocToInitialState) {
      yield BookmarkScreenInitial();
    } else if (event is GetBookmarkScreenData) {
      if (state is BookmarkScreenInitial)
        yield* getBookmarkDataInitialToState();
      else
        yield* getBookmarkDataToState();
    }
  }

  Stream<BookmarkScreenState> getBookmarkDataInitialToState() async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield BookmarkScreenError();

      listBookmarkModel = await dbRepo.listAllBookmark(10, offset: 0);

      yield BookmarkScreenLoaded(
          listBookmarkData: listBookmarkModel, hasReachedMax: false);
    } on Exception {
      yield BookmarkScreenError();
    }
  }

  Stream<BookmarkScreenState> getBookmarkDataToState() async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield BookmarkScreenError();

      BookmarkScreenLoaded bookmarkScreenLoaded = state as BookmarkScreenLoaded;
      listBookmarkModel = await dbRepo.listAllBookmark(10,
          offset: bookmarkScreenLoaded.listBookmarkData.length);

      yield listBookmarkModel.isEmpty
          ? bookmarkScreenLoaded.copyWith(hasReachedMax: true)
          : BookmarkScreenLoaded(
              listBookmarkData:
                  bookmarkScreenLoaded.listBookmarkData + listBookmarkModel,
              hasReachedMax: false);
    } on Exception {
      yield BookmarkScreenError();
    }
  }
}
