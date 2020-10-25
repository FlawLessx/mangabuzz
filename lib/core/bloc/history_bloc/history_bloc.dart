import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mangabuzz/core/model/history/history_model.dart';
import 'package:mangabuzz/core/provider/local/moor_db_provider.dart';
import 'package:mangabuzz/core/repository/local/moor_repository.dart';
import 'package:mangabuzz/screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../../injection_container.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({@required this.mangaDetailScreenBloc}) : super(HistoryInitial());
  final _moorDBRepository = sl.get<MoorDBRepository>();
  final MangaDetailScreenBloc mangaDetailScreenBloc;
  bool loaded = false;

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is AddHistory)
      yield* insertHistoryToState(event);
    else if (event is DeleteHistory) yield* deleteHistoryToState(event);
  }

  Stream<HistoryState> insertHistoryToState(AddHistory event) async* {
    try {
      final data = event.historyModel;
      final result = await _moorDBRepository.getHistory(
          event.historyModel.title, event.historyModel.mangaEndpoint);
      final historyModel = History(
          title: data.title,
          mangaEndpoint: data.mangaEndpoint,
          image: data.image,
          author: data.author,
          type: data.type,
          rating: data.rating,
          selectedIndex: data.selectedIndex,
          chapterReached: data.chapterReached,
          totalChapter: data.totalChapter,
          chapterReachedName: data.chapterReachedName);

      if (result == null) {
        _moorDBRepository.insertHistory(historyModel);

        yield HistorySuccess();
      } else {
        _moorDBRepository.deleteHistory(data.title, data.mangaEndpoint);

        _moorDBRepository.insertHistory(historyModel);
        yield HistorySuccess();
      }
    } catch (e) {
      yield HistoryError(error: e.toString());
    }
  }

  Stream<HistoryState> deleteHistoryToState(DeleteHistory event) async* {
    try {
      _moorDBRepository.deleteHistory(event.title, event.mangaEndpoint);

      yield HistorySuccess();
    } catch (e) {
      yield HistoryError(error: e.toString());
    }
  }
}
