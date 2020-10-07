import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mangabuzz/core/repository/local/moor_repository.dart';
import 'package:mangabuzz/core/util/connectivity_check.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../../../core/model/history/history_model.dart';

part 'history_screen_event.dart';
part 'history_screen_state.dart';

class HistoryScreenBloc extends Bloc<HistoryScreenEvent, HistoryScreenState> {
  HistoryScreenBloc() : super(HistoryScreenInitial());

  // Variables
  final dbRepo = MoorDBRepository();
  final connectivity = ConnectivityCheck();

  @override
  Stream<HistoryScreenState> mapEventToState(
    HistoryScreenEvent event,
  ) async* {
    yield HistoryScreenLoading();

    if (event is GetHistoryScreenData) yield* getHistoryDataToState(event);
  }

  Stream<HistoryScreenState> getHistoryDataToState(
      GetHistoryScreenData event) async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield HistoryScreenError();

      final data =
          await dbRepo.listAllHistory(event.limit, offset: event.offset);

      yield HistoryScreenLoaded(listHistoryData: data);
    } on Exception {
      yield HistoryScreenError();
    }
  }
}
