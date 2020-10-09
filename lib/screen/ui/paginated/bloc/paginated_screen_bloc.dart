import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mangabuzz/core/model/paginated_manga/paginated_manga_model.dart';
import 'package:mangabuzz/core/repository/remote/api_repository.dart';
import 'package:mangabuzz/core/util/connectivity_check.dart';

part 'paginated_screen_event.dart';
part 'paginated_screen_state.dart';

class PaginatedScreenBloc
    extends Bloc<PaginatedScreenEvent, PaginatedScreenState> {
  PaginatedScreenBloc() : super(PaginatedScreenInitial());

  // Variables
  final apiRepo = APIRepository();
  final connectivity = ConnectivityCheck();

  @override
  Stream<PaginatedScreenState> mapEventToState(
    PaginatedScreenEvent event,
  ) async* {
    yield PaginatedScreenLoading();

    if (event is GetPaginatedScreenScreenData)
      yield* getGenreScreenDataToState(event);
  }

  Stream<PaginatedScreenState> getGenreScreenDataToState(
      GetPaginatedScreenScreenData event) async* {
    try {
      var data;

      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield PaginatedScreenError();

      if (event.isGenre == true) {
        data = await apiRepo.getGenre(event.endpoint, event.pageNumber);
      } else {
        if (event.isManga)
          data = await apiRepo.getListManga(event.pageNumber);
        else if (event.isManhua)
          data = await apiRepo.getListManhua(event.pageNumber);
        else
          data = await apiRepo.getListManhwa(event.pageNumber);
      }

      yield PaginatedScreenLoaded(paginatedManga: data, name: event.name);
    } on Exception {
      yield PaginatedScreenError();
    }
  }
}
