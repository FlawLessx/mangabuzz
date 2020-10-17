import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/model/genre/genre_model.dart';
import '../../../../core/model/manga/manga_model.dart';
import '../../../../core/repository/remote/api_repository.dart';
import '../../../../core/util/connectivity_check.dart';
import '../../../../injection_container.dart';

part 'explore_screen_event.dart';
part 'explore_screen_state.dart';

class ExploreScreenBloc extends Bloc<ExploreScreenEvent, ExploreScreenState> {
  ExploreScreenBloc() : super(ExploreScreenInitial());

  // Variables
  final apiRepo = sl.get<APIRepository>();
  final connectivity = sl.get<ConnectivityCheck>();

  @override
  Stream<ExploreScreenState> mapEventToState(
    ExploreScreenEvent event,
  ) async* {
    yield ExploreScreenLoading();

    if (event is GetExploreScreenData)
      yield* getExploreScreenDataToState(event);
  }

  Stream<ExploreScreenState> getExploreScreenDataToState(
      GetExploreScreenData event) async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield ExploreScreenError();

      final genres = await apiRepo.getAllGenre();
      final listManga = await apiRepo.getListManga(1);
      final listManhwa = await apiRepo.getListManhwa(1);
      final listManhua = await apiRepo.getListManhua(1);

      yield ExploreScreenLoaded(
          listGenre: genres,
          listManga: listManga.result.getRange(0, 6).toList(),
          listManhwa: listManhwa.result.getRange(0, 6).toList(),
          listManhua: listManhua.result.getRange(0, 6).toList());
    } on Exception {
      yield ExploreScreenError();
    }
  }
}
