part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class InsertBookmark extends BookmarkEvent {
  final BookmarkModel bookmarkModel;
  InsertBookmark({@required this.bookmarkModel});

  @override
  List<Object> get props => [bookmarkModel];
}

class UpdateBookmark extends BookmarkEvent {
  final BookmarkModel bookmarkModel;
  UpdateBookmark({@required this.bookmarkModel});

  @override
  List<Object> get props => [bookmarkModel];
}

class DeleteBookmark extends BookmarkEvent {
  final BookmarkModel bookmarkModel;
  DeleteBookmark({@required this.bookmarkModel});

  @override
  List<Object> get props => [bookmarkModel];
}
