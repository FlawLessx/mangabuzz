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
  List<HistoryModel> listHistoryModel = [];

  @override
  Stream<HistoryScreenState> mapEventToState(
    HistoryScreenEvent event,
  ) async* {
    if (event is ResetToInitialState) {
      yield HistoryScreenInitial();
    } else if (event is GetHistoryScreenData) {
      if (state is HistoryScreenInitial)
        yield* getHistoryDataInitialToState();
      else
        yield* getHistoryDataToState();
    }
  }

  Stream<HistoryScreenState> getHistoryDataInitialToState() async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield HistoryScreenError();

      listHistoryModel = await dbRepo.listAllHistory(10, offset: 0);

      yield HistoryScreenLoaded(
          listHistoryData: listHistoryModel, hasReachedMax: false);
    } on Exception {
      yield HistoryScreenError();
    }
  }

  Stream<HistoryScreenState> getHistoryDataToState() async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield HistoryScreenError();

      HistoryScreenLoaded historyScreenLoaded = state as HistoryScreenLoaded;
      listHistoryModel = await dbRepo.listAllHistory(10,
          offset: historyScreenLoaded.listHistoryData.length);

      yield listHistoryModel.isEmpty
          ? historyScreenLoaded.copyWith(hasReachedMax: true)
          : HistoryScreenLoaded(
              listHistoryData:
                  historyScreenLoaded.listHistoryData + listHistoryModel,
              hasReachedMax: false);
    } on Exception {
      yield HistoryScreenError();
    }
  }
}
