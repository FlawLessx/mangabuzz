part of 'chapter_screen_bloc.dart';

abstract class ChapterScreenEvent extends Equatable {
  const ChapterScreenEvent();

  @override
  List<Object> get props => [];
}

class InitialStateChapterScreen extends ChapterScreenEvent {}

class GetChapterScreenData extends ChapterScreenEvent {
  final String chapterEndpoint;
  final int selectedIndex;
  final MangaDetail mangaDetail;
  final String mangaEndpoint;
  final bool fromHome;
  GetChapterScreenData(
      {@required this.chapterEndpoint,
      @required this.selectedIndex,
      @required this.mangaDetail,
      this.mangaEndpoint,
      @required this.fromHome});

  @override
  List<Object> get props =>
      [chapterEndpoint, selectedIndex, mangaDetail, mangaEndpoint, fromHome];
}
