part of 'paginated_screen_bloc.dart';

abstract class PaginatedScreenEvent extends Equatable {
  const PaginatedScreenEvent();

  @override
  List<Object> get props => [];
}

class GetPaginatedScreenScreenData extends PaginatedScreenEvent {
  final String name;
  final String endpoint;
  final int pageNumber;
  final bool isGenre;
  final bool isManga;
  final bool isManhwa;
  final bool isManhua;
  GetPaginatedScreenScreenData({
    @required this.name,
    @required this.endpoint,
    @required this.pageNumber,
    @required this.isGenre,
    @required this.isManga,
    @required this.isManhua,
    @required this.isManhwa,
  });

  @override
  List<Object> get props =>
      [name, endpoint, pageNumber, isGenre, isManga, isManhua, isManhwa];
}
