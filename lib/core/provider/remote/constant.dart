class ConstantUrl {
  final baseUrl = 'http://mangabuzz.glitch.me';

  String get hotMangaUpdate => "$baseUrl/api/hot_manga_update/";
  String get bestSeries => "$baseUrl/api/best_series/";
  String get mangaDetail => "$baseUrl/api/manga/detail/";
  String get chapter => "$baseUrl/api/manga/chapter/";
  String get genre => "$baseUrl/api/genre/";
  String get allGenre => "$baseUrl/api/genre/all";
  String get latestUpdate => "$baseUrl/api/latest_update/";
  String get search => "$baseUrl/api/search/";
  String get listManga => "$baseUrl/api/manga/";
  String get listManhua => "$baseUrl/api/manhua/";
  String get listManhwa => "$baseUrl/api/manhwa/";
}
