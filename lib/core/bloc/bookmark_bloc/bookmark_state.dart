part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkSuccess extends BookmarkState {}

class BookmarkError extends BookmarkState {
  final String error;
  BookmarkError({@required this.error});

  @override
  List<Object> get props => [error];
}
