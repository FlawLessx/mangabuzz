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
    final response = await client.get(
      _constant.hotMangaUpdate,
    );

    if (response.statusCode == 200) {
      return mangaFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<BestSeries>> getBestSeries() async {
    final response = await client.get(_constant.bestSeries);

    if (response.statusCode == 200) {
      return bestSeriesFromJson(response.body);
    } else {
      print(response.body);
      throw Exception();
    }
  }

  Future<MangaDetail> getMangaDetail(String mangaEndpoint) async {
    final response = await client.get("${_constant.mangaDetail}$mangaEndpoint");

    if (response.statusCode == 200) {
      return mangaDetailFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<LatestUpdate> getLatestUpdate(int pageNumber) async {
    final response = await client.get("${_constant.latestUpdate}$pageNumber");

    if (response.statusCode == 200) {
      return latestUpdateFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<Genre>> getAllGenre() async {
    final response = await client.get(_constant.allGenre);

    if (response.statusCode == 200) {
      return genreFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<PaginatedManga> getGenre(String genreEndpoint, int pageNumber) async {
    final response =
        await client.get("${_constant.latestUpdate}$genreEndpoint$pageNumber");

    if (response.statusCode == 200) {
      return paginatedMangaFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<Chapter>> getChapter(String chapterEndpoint) async {
    final response = await client.get("${_constant.chapter}$chapterEndpoint");

    if (response.statusCode == 200) {
      return chapterFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<Manga>> getSearch(String query) async {
    final response = await client.get("${_constant.search}?query=$query");

    if (response.statusCode == 200) {
      return mangaFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<PaginatedManga> getListManga(int pageNumber) async {
    final response = await client.get("${_constant.listManga}$pageNumber");

    if (response.statusCode == 200) {
      return paginatedMangaFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<PaginatedManga> getListManhua(int pageNumber) async {
    final response = await client.get("${_constant.listManhua}$pageNumber");

    if (response.statusCode == 200) {
      return paginatedMangaFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<PaginatedManga> getListManhwa(int pageNumber) async {
    final response = await client.get("${_constant.listManhwa}$pageNumber");

    if (response.statusCode == 200) {
      return paginatedMangaFromJson(response.body);
    } else {
      throw Exception();
    }
  }
}
