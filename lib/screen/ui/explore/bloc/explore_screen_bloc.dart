import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mangabuzz/core/model/genre/genre_model.dart';
import 'package:mangabuzz/core/model/manga/manga_model.dart';
import 'package:mangabuzz/core/repository/remote/api_repository.dart';

part 'explore_screen_event.dart';
part 'explore_screen_state.dart';

class ExploreScreenBloc extends Bloc<ExploreScreenEvent, ExploreScreenState> {
  ExploreScreenBloc() : super(ExploreScreenInitial());

  // Variables
  final apiRepo = APIRepository();

  @override
  Stream<ExploreScreenState> mapEventToState(
    ExploreScreenEvent event,
  ) async* {
    yield ExploreScreenLoading();

    if (event is GetExploreScreenEvent)
      yield* getExploreScreenDataToState(event);
  }

  Stream<ExploreScreenState> getExploreScreenDataToState(
      GetExploreScreenEvent event) async* {
    try {
      final genres = await apiRepo.getAllGenre();
      final listManga = await apiRepo.getListManga(1);
      final listManhwa = await apiRepo.getListManhwa(1);
      final listManhua = await apiRepo.getListManhua(1);

      yield ExploreScreenLoaded(
          listGenre: genres,
          listManga: listManga.result,
          listManhwa: listManhwa.result,
          listManhua: listManhua.result);
    } on Exception {
      yield ExploreScreenError();
    }
  }
}
