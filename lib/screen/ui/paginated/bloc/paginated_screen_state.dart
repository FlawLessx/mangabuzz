part of 'paginated_screen_bloc.dart';

abstract class PaginatedScreenState extends Equatable {
  const PaginatedScreenState();

  @override
  List<Object> get props => [];
}

class PaginatedScreenInitial extends PaginatedScreenState {}

class PaginatedScreenLoading extends PaginatedScreenState {}

class PaginatedScreenLoaded extends PaginatedScreenState {
  final PaginatedManga paginatedManga;
  final String name;

  PaginatedScreenLoaded({@required this.paginatedManga, @required this.name});

  @override
  List<Object> get props => [paginatedManga, name];
}

class PaginatedScreenError extends PaginatedScreenState {}
