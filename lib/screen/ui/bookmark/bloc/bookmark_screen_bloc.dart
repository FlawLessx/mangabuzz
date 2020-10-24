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

  @override
  Stream<BookmarkScreenState> mapEventToState(
    BookmarkScreenEvent event,
  ) async* {
    yield BookmarkScreenLoading();

    if (event is GetBookmarkScreenData) {
      yield* getBookmarkDataToState();
    }
  }

  Stream<BookmarkScreenState> getBookmarkDataToState() async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield BookmarkScreenError();

      final listBookmarkModel = await dbRepo.listAllBookmark();

      yield BookmarkScreenLoaded(
          listBookmarkData: listBookmarkModel.reversed.toList());
    } on Exception {
      yield BookmarkScreenError();
    }
  }
}
