part of 'chapter_screen_bloc.dart';

abstract class ChapterScreenState extends Equatable {
  const ChapterScreenState();

  @override
  List<Object> get props => [];
}

class ChapterScreenInitial extends ChapterScreenState {}

class ChapterScreenLoading extends ChapterScreenState {}

class ChapterScreenLoaded extends ChapterScreenState {
  final int selectedIndex;
  final MangaDetail mangaDetail;
  final List<Chapter> chapterImg;
  final List<ChapterList> chapterList;
  ChapterScreenLoaded(
      {@required this.selectedIndex,
      @required this.mangaDetail,
      @required this.chapterImg,
      @required this.chapterList});

  @override
  List<Object> get props =>
      [selectedIndex, mangaDetail, chapterImg, chapterList];
}

class ChapterScreenError extends ChapterScreenState {}
