part of 'drawer_widget_bloc.dart';

abstract class DrawerWidgetState extends Equatable {
  const DrawerWidgetState();

  @override
  List<Object> get props => [];
}

class DrawerWidgetInitial extends DrawerWidgetState {}

class DrawerWidgetLoading extends DrawerWidgetState {}

class DrawerWidgetLoaded extends DrawerWidgetState {
  final List<Genre> genreList;
  DrawerWidgetLoaded({@required this.genreList});

  @override
  List<Object> get props => [genreList];
}

class DrawerWidgetError extends DrawerWidgetState {}
