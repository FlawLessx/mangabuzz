import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/model/genre/genre_model.dart';
import '../../../../core/repository/remote/api_repository.dart';
import '../../../../core/util/connectivity_check.dart';
import '../../../../injection_container.dart';

part 'drawer_widget_event.dart';
part 'drawer_widget_state.dart';

class DrawerWidgetBloc extends Bloc<DrawerWidgetEvent, DrawerWidgetState> {
  DrawerWidgetBloc() : super(DrawerWidgetInitial());

  // Variables
  final apiRepo = sl.get<APIRepository>();
  final connectivity = sl.get<ConnectivityCheck>();

  @override
  Stream<DrawerWidgetState> mapEventToState(
    DrawerWidgetEvent event,
  ) async* {
    yield DrawerWidgetLoading();

    if (event is GetDrawerData) yield* getDrawerDataToState(event);
  }

  Stream<DrawerWidgetState> getDrawerDataToState(
      DrawerWidgetEvent event) async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield DrawerWidgetError();

      final data = await apiRepo.getAllGenre();

      yield DrawerWidgetLoaded(genreList: data);
    } on Exception {
      yield DrawerWidgetError();
    }
  }
}
