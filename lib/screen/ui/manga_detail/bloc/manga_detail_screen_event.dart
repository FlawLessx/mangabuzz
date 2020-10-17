part of 'manga_detail_screen_bloc.dart';

abstract class MangaDetailScreenEvent extends Equatable {
  const MangaDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class GetMangaDetailScreenData extends MangaDetailScreenEvent {
  final String mangaEndpoint;
  final String title;
  GetMangaDetailScreenData(
      {@required this.mangaEndpoint, @required this.title});

  @override
  List<Object> get props => [mangaEndpoint, title];
}
