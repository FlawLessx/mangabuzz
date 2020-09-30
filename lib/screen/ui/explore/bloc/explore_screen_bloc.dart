import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mangabuzz/core/model/genre/genre_model.dart';
import 'package:mangabuzz/core/model/manga/manga_model.dart';

part 'explore_screen_event.dart';
part 'explore_screen_state.dart';

class ExploreScreenBloc extends Bloc<ExploreScreenEvent, ExploreScreenState> {
  ExploreScreenBloc() : super(ExploreScreenInitial());

  @override
  Stream<ExploreScreenState> mapEventToState(
    ExploreScreenEvent event,
  ) async* {
    yield ExploreScreenLoading();
  }
}
