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
  MangaDetailScreenLoaded(
      {@required this.mangaDetail,
      @required this.isBookmarked,
      @required this.historyModel});

  @override
  List<Object> get props => [mangaDetail, isBookmarked, historyModel];
}

class MangaDetailScreenError extends MangaDetailScreenState {}
