part of 'bookmark_screen_bloc.dart';

abstract class BookmarkScreenEvent extends Equatable {
  const BookmarkScreenEvent();

  @override
  List<Object> get props => [];
}

class GetBookmarkScreenData extends BookmarkScreenEvent {
  final int limit;
  final int offset;
  GetBookmarkScreenData({@required this.limit, this.offset});

  @override
  List<Object> get props => [limit, offset];
}
