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
  final bool hasReachedMax;
  BookmarkScreenLoaded(
      {@required this.listBookmarkData, @required this.hasReachedMax});

  BookmarkScreenLoaded copyWith(
      {List<BookmarkModel> listBookmarkData, bool hasReachedMax}) {
    return BookmarkScreenLoaded(
        listBookmarkData: listBookmarkData ?? this.listBookmarkData,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [listBookmarkData, hasReachedMax];
}

class BookmarkScreenError extends BookmarkScreenState {}
