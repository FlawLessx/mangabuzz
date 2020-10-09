part of 'bookmark_screen_bloc.dart';

abstract class BookmarkScreenEvent extends Equatable {
  const BookmarkScreenEvent();

  @override
  List<Object> get props => [];
}

class ResetStateToInitial extends BookmarkScreenEvent {}

class GetBookmarkScreenData extends BookmarkScreenEvent {}
