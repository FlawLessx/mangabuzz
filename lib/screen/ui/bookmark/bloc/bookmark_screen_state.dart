part of 'bookmark_screen_bloc.dart';

abstract class BookmarkScreenState extends Equatable {
  const BookmarkScreenState();

  @override
  List<Object> get props => [];
}

class BookmarkScreenInitial extends BookmarkScreenState {}

class BookmarkScreenLoading extends BookmarkScreenState {}

class BookmarkScreenLoaded extends BookmarkScreenState {
  final List<BookmarkModel> listBookmarkData;
  BookmarkScreenLoaded({@required this.listBookmarkData});

  @override
  List<Object> get props => [listBookmarkData];
}

class BookmarkScreenError extends BookmarkScreenState {}
