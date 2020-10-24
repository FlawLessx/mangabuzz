part of 'manga_detail_screen_bloc.dart';

abstract class MangaDetailScreenEvent extends Equatable {
  const MangaDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class UpdateHistoryBottomNavbar extends MangaDetailScreenEvent {
  final MangaDetail mangaDetail;
  final bool isBookmarked;
  final HistoryModel historyModel;
  final BookmarkModel bookmarkModel;

  UpdateHistoryBottomNavbar(
      {@required this.mangaDetail,
      @required this.isBookmarked,
      @required this.bookmarkModel,
      this.historyModel});

  @override
  List<Object> get props =>
      [mangaDetail, isBookmarked, historyModel, bookmarkModel];
}

class GetMangaDetailScreenData extends MangaDetailScreenEvent {
  final String mangaEndpoint;
  final String title;
  GetMangaDetailScreenData(
      {@required this.mangaEndpoint, @required this.title});

  @override
  List<Object> get props => [mangaEndpoint, title];
}
