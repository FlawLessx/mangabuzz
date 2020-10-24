part of 'manga_detail_screen_bloc.dart';

abstract class MangaDetailScreenState extends Equatable {
  const MangaDetailScreenState();

  @override
  List<Object> get props => [];
}

class MangaDetailScreenInitial extends MangaDetailScreenState {}

class MangaDetailScreenLoading extends MangaDetailScreenState {}

class MangaDetailScreenLoaded extends MangaDetailScreenState {
  final MangaDetail mangaDetail;
  final bool isBookmarked;
  final HistoryModel historyModel;
  final BookmarkModel bookmarkModel;

  MangaDetailScreenLoaded(
      {@required this.mangaDetail,
      @required this.isBookmarked,
      @required this.bookmarkModel,
      this.historyModel});

  @override
  List<Object> get props => [
        mangaDetail,
        isBookmarked,
        historyModel,
        bookmarkModel,
      ];
}

class MangaDetailScreenError extends MangaDetailScreenState {}
