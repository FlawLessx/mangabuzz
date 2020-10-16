import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mangabuzz/core/localization/langguage_constants.dart';

part 'settings_screen_state.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenState> {
  SettingsScreenCubit() : super(SettingsScreenInitial());

  int selectedIndex;

  Future<void> getSelectedIndex() async {
    final data = await getLocaleCode();
    if (data == "en")
      selectedIndex = 0;
    else
      selectedIndex = 1;

    emit(SettingsScreenLoaded(selectedIndex: selectedIndex));
  }

  Future<void> clearCache() async {
    try {
      await DefaultCacheManager().emptyCache();
      emit(SettingsScreenLoaded(selectedIndex: selectedIndex));
    } catch (e) {
      emit(SettingsScreenError());
    }
  }
}
