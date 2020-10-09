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
    if (event is AddHistory)
      yield* insertHistoryToState(event);
    else if (event is UpdateHistory)
      yield* updateHistoryToState(event);
    else if (event is DeleteHistory) yield* deleteHistoryToState(event);
  }

  Stream<HistoryState> insertHistoryToState(AddHistory event) async* {
    try {
      final data = event.historyModel;

      final result = await _moorDBRepository.getHistory(
          event.historyModel.title, event.historyModel.mangaEndpoint);

      if (result == null) {
        _moorDBRepository.insertHistory(History(
            title: data.title,
            mangaEndpoint: data.mangaEndpoint,
            image: data.image,
            author: data.author,
            type: data.type,
            rating: data.rating,
            selectedIndex: data.selectedIndex,
            chapterReached: data.chapterReached,
            totalChapter: data.totalChapter));

        yield HistorySuccess();
      } else {
        yield* updateHistoryToState(UpdateHistory(historyModel: data));
      }
    } catch (e) {
      yield HistoryError(error: e.toString());
    }
  }

  Stream<HistoryState> updateHistoryToState(UpdateHistory event) async* {
    try {
      final data = event.historyModel;

      final result = await _moorDBRepository.getHistory(
          event.historyModel.title, event.historyModel.mangaEndpoint);

      _moorDBRepository.updateHistory(History(
          title: data.title,
          mangaEndpoint: data.mangaEndpoint,
          image: data.image,
          author: data.author,
          type: data.type,
          rating: data.rating,
          selectedIndex: result.totalChapter != data.totalChapter
              ? data.selectedIndex
              : data.selectedIndex + 1,
          chapterReached: data.chapterReached,
          totalChapter: data.totalChapter));

      yield HistorySuccess();
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
