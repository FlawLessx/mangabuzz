import 'package:http/http.dart' as http;
import 'package:mangabuzz/core/model/manga_detail/manga_detail_model.dart';
import 'package:moor/moor.dart';

import '../../model/best_series/best_series_model.dart';
import '../../model/chapter/chapter_model.dart';
import '../../model/genre/genre_model.dart';
import '../../model/latest_update/latest_update_model.dart';
import '../../model/manga/manga_model.dart';
import '../../model/paginated_manga/paginated_manga_model.dart';
import 'constant.dart';

class APIProvider {
  final http.Client client;
  final ConstantUrl _constant = ConstantUrl();

  APIProvider({@required this.client});

  Future<List<Manga>> getHotMangaUpdate() async {
    try {
      final response = await client.get(_constant.hotMangaUpdate);
      return mangaFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<BestSeries>> getBestSeries() async {
    try {
      final response = await client.get(_constant.bestSeries);
      return bestSeriesFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MangaDetail> getMangaDetail(String mangaEndpoint) async {
    try {
      final response =
          await client.get("${_constant.mangaDetail}$mangaEndpoint");
      return mangaDetailFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LatestUpdate> getLatestUpdate(int pageNumber) async {
    try {} catch (e) {
      throw Exception(e.toString());
    }

    final response = await client.get("${_constant.latestUpdate}$pageNumber");

    if (response.statusCode == 200) {
      return latestUpdateFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<Genre>> getAllGenre() async {
    try {
      final response = await client.get(_constant.allGenre);
      return genreFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PaginatedManga> getGenre(String genreEndpoint, int pageNumber) async {
    try {
      final response =
          await client.get("${_constant.genre}$genreEndpoint$pageNumber");
      return paginatedMangaFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Chapter>> getChapter(String chapterEndpoint) async {
    try {
      final response = await client.get("${_constant.chapter}$chapterEndpoint");
      return chapterFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Manga>> getSearch(String query) async {
    try {
      final response = await client.get("${_constant.search}?query=$query");
      return mangaFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PaginatedManga> getListManga(int pageNumber) async {
    try {
      final response = await client.get("${_constant.listManga}$pageNumber");
      return paginatedMangaFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PaginatedManga> getListManhua(int pageNumber) async {
    try {
      final response = await client.get("${_constant.listManhua}$pageNumber");
      return paginatedMangaFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PaginatedManga> getListManhwa(int pageNumber) async {
    try {
      final response = await client.get("${_constant.listManhwa}$pageNumber");
      return paginatedMangaFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
