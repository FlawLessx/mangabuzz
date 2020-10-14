part of 'settings_screen_bloc.dart';

abstract class SettingsScreenEvent extends Equatable {
  const SettingsScreenEvent();

  @override
  List<Object> get props => [];
}

class ClearCache extends SettingsScreenEvent {}
