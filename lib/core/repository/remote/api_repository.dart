import 'package:http/http.dart' as http;
import 'package:mangabuzz/core/model/manga_detail/manga_detail_model.dart';

import '../../model/best_series/best_series_model.dart';
import '../../model/chapter/chapter_model.dart';
import '../../model/genre/genre_model.dart';
import '../../model/latest_update/latest_update_model.dart';
import '../../model/manga/manga_model.dart';
import '../../model/paginated_manga/paginated_manga_model.dart';
import '../../provider/remote/api_provider.dart';

class APIRepository {
  APIProvider _apiProvider = APIProvider(client: http.Client());

  Future<List<Manga>> getHotMangaUpdate() => _apiProvider.getHotMangaUpdate();
  Future<List<BestSeries>> getBestSeries() => _apiProvider.getBestSeries();
  Future<MangaDetail> getMangaDetail(mangaEndpoint) =>
      _apiProvider.getMangaDetail(mangaEndpoint);
  Future<LatestUpdate> getLatestUpdate(int pageNumber) =>
      _apiProvider.getLatestUpdate(pageNumber);
  Future<List<Genre>> getAllGenre() => _apiProvider.getAllGenre();
  Future<PaginatedManga> getGenre(String genreEndpoint, int pageNumber) =>
      _apiProvider.getGenre(genreEndpoint, pageNumber);
  Future<List<Chapter>> getChapter(String chapterEndpoint) =>
      _apiProvider.getChapter(chapterEndpoint);
  Future<List<Manga>> getSearch(String query) => _apiProvider.getSearch(query);
  Future<PaginatedManga> getListManga(int pageNumber) =>
      _apiProvider.getListManga(pageNumber);
  Future<PaginatedManga> getListManhua(int pageNumber) =>
      _apiProvider.getListManhua(pageNumber);
  Future<PaginatedManga> getListManhwa(int pageNumber) =>
      _apiProvider.getListManhwa(pageNumber);
}
