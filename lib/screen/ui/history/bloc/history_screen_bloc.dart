import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../../../core/model/history/history_model.dart';
import '../../../../core/repository/local/moor_repository.dart';
import '../../../../core/util/connectivity_check.dart';
import '../../../../injection_container.dart';

part 'history_screen_event.dart';
part 'history_screen_state.dart';

class HistoryScreenBloc extends Bloc<HistoryScreenEvent, HistoryScreenState> {
  HistoryScreenBloc() : super(HistoryScreenInitial());

  // Variables
  final dbRepo = sl.get<MoorDBRepository>();
  final connectivity = sl.get<ConnectivityCheck>();
  List<HistoryModel> listHistoryModel = [];
  int startIndex;
  int endIndex;

  @override
  Stream<HistoryScreenState> mapEventToState(
    HistoryScreenEvent event,
  ) async* {
    if (event is ResetHistoryScreenBlocToInitialState) {
      yield HistoryScreenInitial();
    } else if (event is GetHistoryScreenData) {
      if (state is HistoryScreenInitial) {
        yield HistoryScreenLoading();
        yield* getHistoryDataInitialToState();
      } else
        yield* getHistoryDataToState();
    }
  }

  Stream<HistoryScreenState> getHistoryDataInitialToState() async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield HistoryScreenError();

      listHistoryModel = await dbRepo.listAllHistory();
      listHistoryModel = listHistoryModel.reversed.toList();

      startIndex = 0;
      if (listHistoryModel.length < 6) {
        endIndex = listHistoryModel.length;
      } else {
        endIndex = 6;
      }

      final data = listHistoryModel.getRange(startIndex, endIndex).toList();

      yield HistoryScreenLoaded(listHistoryData: data, hasReachedMax: false);
    } on Exception {
      yield HistoryScreenError();
    }
  }

  Stream<HistoryScreenState> getHistoryDataToState() async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield HistoryScreenError();

      List<HistoryModel> data;
      HistoryScreenLoaded historyScreenLoaded = state as HistoryScreenLoaded;

      if (startIndex <= listHistoryModel.length) {
        startIndex = historyScreenLoaded.listHistoryData.length + 1;

        if (endIndex + 6 <= listHistoryModel.length) {
          endIndex = endIndex + 6;
        } else {
          endIndex = endIndex + (listHistoryModel.length - endIndex);
        }

        if (endIndex != listHistoryModel.length) {
          data = historyScreenLoaded.listHistoryData +
              listHistoryModel.getRange(startIndex, endIndex).toList();
        }
      }

      yield endIndex >= listHistoryModel.length
          ? historyScreenLoaded.copyWith(hasReachedMax: true)
          : HistoryScreenLoaded(listHistoryData: data, hasReachedMax: false);
    } on Exception {
      yield HistoryScreenError();
    }
  }
}
