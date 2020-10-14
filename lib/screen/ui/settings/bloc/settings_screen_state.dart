part of 'settings_screen_bloc.dart';

abstract class SettingsScreenState extends Equatable {
  const SettingsScreenState();

  @override
  List<Object> get props => [];
}

class SettingsScreenInitial extends SettingsScreenState {}

class SettingsScreenLoading extends SettingsScreenState {}

class SettingsScreenLoaded extends SettingsScreenState {}

class SettingsScreenError extends SettingsScreenState {}
