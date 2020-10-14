import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

part 'settings_screen_event.dart';
part 'settings_screen_state.dart';

class SettingsScreenBloc
    extends Bloc<SettingsScreenEvent, SettingsScreenState> {
  SettingsScreenBloc() : super(SettingsScreenInitial());

  @override
  Stream<SettingsScreenState> mapEventToState(
      SettingsScreenEvent event) async* {
    yield SettingsScreenLoading();

    if (event is ClearCache) yield* clearCacheToState(event);
  }

  Stream<SettingsScreenState> clearCacheToState(ClearCache event) async* {
    try {
      await DefaultCacheManager().emptyCache();
      yield SettingsScreenLoaded();
    } on Exception {
      yield SettingsScreenError();
    }
  }
}
