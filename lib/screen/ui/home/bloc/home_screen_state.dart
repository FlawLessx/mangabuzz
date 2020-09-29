part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
  
  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}
