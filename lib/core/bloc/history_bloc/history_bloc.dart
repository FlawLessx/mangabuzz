import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mangabuzz/core/model/history/history_model.dart';
import 'package:mangabuzz/core/provider/local/moor_db_provider.dart';
import 'package:mangabuzz/core/repository/local/moor_repository.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());
  MoorDBRepository _moorDBRepository = MoorDBRepository();

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is InsertHistory)
      yield* insertHistoryToState(event);
    else if (event is UpdateHistory)
      yield* updateHistoryToState(event);
    else if (event is DeleteHistory) yield* deleteHistoryToState(event);
  }

  Stream<HistoryState> insertHistoryToState(InsertHistory event) async* {
    try {
      final data = event.historyModel;
      await _moorDBRepository.insertHistory(HistorysCompanion.insert(
          title: data.title,
          mangaEndpoint: data.mangaEndpoint,
          image: data.image,
          author: Value(data.author),
          type: Value(data.type),
          rating: Value(data.rating),
          chapterReached: Value(data.chapterReached),
          totalChapter: Value(data.totalChapter)));

      yield HistorySuccess();
    } catch (e) {
      yield HistoryError(error: e.toString());
    }
  }

  Stream<HistoryState> updateHistoryToState(UpdateHistory event) async* {
    try {
      final data = event.historyModel;
      await _moorDBRepository.updateHistory(HistorysCompanion.insert(
          title: data.title,
          mangaEndpoint: data.mangaEndpoint,
          image: data.image,
          author: Value(data.author),
          type: Value(data.type),
          rating: Value(data.rating),
          chapterReached: Value(data.chapterReached),
          totalChapter: Value(data.totalChapter)));
      yield HistorySuccess();
    } catch (e) {
      yield HistoryError(error: e.toString());
    }
  }

  Stream<HistoryState> deleteHistoryToState(DeleteHistory event) async* {
    try {
      final data = event.historyModel;
      await _moorDBRepository.updateHistory(HistorysCompanion.insert(
          title: data.title,
          mangaEndpoint: data.mangaEndpoint,
          image: data.image,
          author: Value(data.author),
          type: Value(data.type),
          rating: Value(data.rating),
          chapterReached: Value(data.chapterReached),
          totalChapter: Value(data.totalChapter)));

      yield HistorySuccess();
    } catch (e) {
      yield HistoryError(error: e.toString());
    }
  }
}
