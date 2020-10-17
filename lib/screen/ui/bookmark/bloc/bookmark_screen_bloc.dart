import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../../../core/model/bookmark/bookmark_model.dart';
import '../../../../core/repository/local/moor_repository.dart';
import '../../../../core/util/connectivity_check.dart';
import '../../../../injection_container.dart';

part 'bookmark_screen_event.dart';
part 'bookmark_screen_state.dart';

class BookmarkScreenBloc
    extends Bloc<BookmarkScreenEvent, BookmarkScreenState> {
  BookmarkScreenBloc() : super(BookmarkScreenInitial());

  // Variables
  final dbRepo = sl.get<MoorDBRepository>();
  final connectivity = sl.get<ConnectivityCheck>();
  List<BookmarkModel> listBookmarkModel = [];
  int startIndex, endIndex;

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

      listBookmarkModel = await dbRepo.listAllBookmark();
      listBookmarkModel = listBookmarkModel.reversed.toList();

      startIndex = 0;
      if (listBookmarkModel.length < 6) {
        endIndex = listBookmarkModel.length;
      } else {
        endIndex = 6;
      }
      final data = listBookmarkModel.getRange(startIndex, endIndex).toList();

      yield BookmarkScreenLoaded(listBookmarkData: data, hasReachedMax: false);
    } on Exception {
      yield BookmarkScreenError();
    }
  }

  Stream<BookmarkScreenState> getBookmarkDataToState() async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield BookmarkScreenError();

      List<BookmarkModel> data;
      BookmarkScreenLoaded bookmarkScreenLoaded = state as BookmarkScreenLoaded;

      if (startIndex <= listBookmarkModel.length) {
        startIndex = bookmarkScreenLoaded.listBookmarkData.length + 1;

        if (endIndex + 6 <= listBookmarkModel.length) {
          endIndex = endIndex + 6;
        } else {
          endIndex = endIndex + (listBookmarkModel.length - endIndex);
        }

        if (endIndex != listBookmarkModel.length) {
          data = bookmarkScreenLoaded.listBookmarkData +
              listBookmarkModel.getRange(startIndex, endIndex).toList();
        }
      }

      yield endIndex >= listBookmarkModel.length
          ? bookmarkScreenLoaded.copyWith(hasReachedMax: true)
          : BookmarkScreenLoaded(listBookmarkData: data, hasReachedMax: false);
    } on Exception {
      yield BookmarkScreenError();
    }
  }
}
