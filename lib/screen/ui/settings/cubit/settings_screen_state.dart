part of 'settings_screen_cubit.dart';

abstract class SettingsScreenState extends Equatable {
  const SettingsScreenState();

  @override
  List<Object> get props => [];
}

class SettingsScreenInitial extends SettingsScreenState {}

class SettingsScreenLoading extends SettingsScreenState {}

class SettingsScreenLoaded extends SettingsScreenState {
  final int selectedIndex;
  SettingsScreenLoaded({this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}

class SettingsScreenError extends SettingsScreenState {}
