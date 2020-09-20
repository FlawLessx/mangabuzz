import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moor/moor.dart';

import '../../error/exception.dart';
import '../../model/best_series/best_series_model.dart';
import '../../model/genre/all_genre_model.dart';
import '../../model/latest_update/latest_update_model.dart';
import '../../model/manga/manga_model.dart';
import 'constant.dart';

class APIRepository {
  final http.Client client;
  final ConstantUrl _constant = ConstantUrl();

  APIRepository({@required this.client});

  Future<List<Manga>> getHotMangaUpdate() async {
    final response = await client.get(
      _constant.hotMangaUpdate,
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return mangaFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<BestSeries>> getBestSeries() async {
    final response = await client.get(_constant.bestSeries);

    if (response.statusCode == 200) {
      return bestSeriesFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<LatestUpdate>> getLatestUpdate(int pageNumber) async {
    final response = await client.get("${_constant.latestUpdate}$pageNumber");

    if (response.statusCode == 200) {
      return latestUpdateFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<AllGenre>> getAllGenre() async {
    final response = await client.get(_constant.allGenre);

    if (response.statusCode == 200) {
      return allGenreFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<Manga>> getGenre(String genreEndpoint, int pageNumber) async {
    final response =
        await client.get("${_constant.latestUpdate}$genreEndpoint$pageNumber");

    if (response.statusCode == 200) {
      return mangaFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<Manga>> getChapter(String chapterEndpoint) async {
    final response = await client.get("${_constant.chapter}$chapterEndpoint");

    if (response.statusCode == 200) {
      return mangaFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<Manga>> getSearch(String query) async {
    final response = await client.get("${_constant.search}?query=$query");

    if (response.statusCode == 200) {
      return mangaFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<Manga>> getListManga(int pageNumber) async {
    final response = await client.get("${_constant.listManga}$pageNumber");

    if (response.statusCode == 200) {
      return mangaFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<Manga>> getListManhua(int pageNumber) async {
    final response = await client.get("${_constant.listManhua}$pageNumber");

    if (response.statusCode == 200) {
      return mangaFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<Manga>> getListManhwa(int pageNumber) async {
    final response = await client.get("${_constant.listManhwa}$pageNumber");

    if (response.statusCode == 200) {
      return mangaFromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
