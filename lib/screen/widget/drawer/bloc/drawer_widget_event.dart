part of 'drawer_widget_bloc.dart';

abstract class DrawerWidgetEvent extends Equatable {
  const DrawerWidgetEvent();

  @override
  List<Object> get props => [];
}

class GetDrawerData extends DrawerWidgetEvent {}
