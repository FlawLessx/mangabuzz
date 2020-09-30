import 'dart:io';

import 'package:mangabuzz/core/model/best_series/best_series_model.dart';
import 'package:mangabuzz/core/model/chapter/chapter_model.dart';
import 'package:mangabuzz/core/model/genre/genre_model.dart';
import 'package:mangabuzz/core/model/manga/manga_model.dart';
import 'package:mangabuzz/core/model/manga_detail/manga_detail_model.dart';
import 'package:mangabuzz/core/model/paginated_manga/paginated_manga_model.dart';
import 'package:mangabuzz/core/provider/remote/api_provider.dart';
import 'package:mangabuzz/core/provider/remote/constant.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../fixtures/file_reader.dart';

class MockClient extends Mock with http.Client {}

void main() {
  http.Client mockClient;
  ConstantUrl url;
  APIProvider apiProvider;

  setUp(() {
    mockClient = MockClient();
    url = ConstantUrl();
    apiProvider = APIProvider(client: mockClient);
  });

  group("Hot Manga Update Test", () {
    test('Get hot manga update', () async {
      when(mockClient.get(url.hotMangaUpdate)).thenAnswer((_) async =>
          Future.value(http.Response(fixture('hot_manga_update'), 200)));

      var result = await apiProvider.getHotMangaUpdate();
      expect(result.first.title, "Black Clover");
    });

    test('Fail test hot manga update', () async {
      when(mockClient.get(url.hotMangaUpdate)).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getHotMangaUpdate(), throwsException);
    });
  });

  group("Latest Update Test", () {
    int pageNumber = 1;

    test('Get latest update', () async {
      when(mockClient.get(url.latestUpdate + pageNumber.toString())).thenAnswer(
          (_) async =>
              Future.value(http.Response(fixture('latest_update'), 200)));

      var result = await apiProvider.getLatestUpdate(pageNumber);
      expect(result.latestUpdateList.first.title, "unOrdinary");
    });

    test('Fail test latest update', () async {
      when(mockClient.get(url.latestUpdate + pageNumber.toString())).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getLatestUpdate(pageNumber), throwsException);
    });
  });

  group("Manga Detail Test", () {
    String mangaEndpoint = 'ajin/';

    test('Get manga detail', () async {
      when(mockClient.get(url.mangaDetail + mangaEndpoint))
          .thenAnswer((_) async => Future.value(
                http.Response(fixture('manga_detail'), 200, headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                }),
              ));

      var result = await apiProvider.getMangaDetail(mangaEndpoint);
      expect(result, isA<MangaDetail>());
    });

    test('Fail test latest update', () async {
      when(mockClient.get(url.mangaDetail + mangaEndpoint)).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getMangaDetail(mangaEndpoint), throwsException);
    });
  });

  group("Best Series Test", () {
    test('Get best series', () async {
      when(mockClient.get(url.bestSeries)).thenAnswer((_) async => Future.value(
            http.Response(fixture('best_series'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }),
          ));

      var result = await apiProvider.getBestSeries();
      expect(result.first, isA<BestSeries>());
    });

    test('Fail test best series', () async {
      when(mockClient.get(url.bestSeries)).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getBestSeries(), throwsException);
    });
  });

  group("All Genre Test", () {
    test('Get all genre', () async {
      when(mockClient.get(url.allGenre)).thenAnswer((_) async => Future.value(
            http.Response(fixture('all_genre'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }),
          ));

      var result = await apiProvider.getAllGenre();
      expect(result.first, isA<Genre>());
    });

    test('Fail test all genre', () async {
      when(mockClient.get(url.allGenre)).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getAllGenre(), throwsException);
    });
  });

  group("Genre Test", () {
    String genreEndpoint = "action/";
    int pageNumber = 1;

    test('Get all genre', () async {
      when(mockClient.get("${url.latestUpdate}$genreEndpoint$pageNumber"))
          .thenAnswer((_) async => Future.value(
                http.Response(fixture('genre'), 200),
              ));

      var result = await apiProvider.getGenre(genreEndpoint, pageNumber);
      expect(result, isA<PaginatedManga>());
    });

    test('Fail test genre', () async {
      when(mockClient.get("${url.latestUpdate}$genreEndpoint$pageNumber"))
          .thenAnswer((_) async =>
              Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getGenre(genreEndpoint, pageNumber), throwsException);
    });
  });

  group("Chapter Test", () {
    String chapterEndpoint = "ajin-chapter-82/";

    test('Get chapter', () async {
      when(mockClient.get("${url.chapter}$chapterEndpoint"))
          .thenAnswer((_) async => Future.value(
                http.Response(fixture('chapter'), 200),
              ));

      var result = await apiProvider.getChapter(chapterEndpoint);
      expect(result.first, isA<Chapter>());
    });

    test('Fail test chapter', () async {
      when(mockClient.get("${url.chapter}$chapterEndpoint")).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getChapter(chapterEndpoint), throwsException);
    });
  });

  group("Search Test", () {
    String query = "One Piece";

    test('Get search', () async {
      when(mockClient.get("${url.search}?query=$query"))
          .thenAnswer((_) async => Future.value(
                http.Response(fixture('hot_manga_update'), 200),
              ));

      var result = await apiProvider.getSearch(query);
      expect(result.first, isA<Manga>());
    });

    test('Fail test chapter', () async {
      when(mockClient.get("${url.search}?query=$query")).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getSearch(query), throwsException);
    });
  });

  group("List Manga Test", () {
    int pageNumber = 1;

    test('Get list manga', () async {
      when(mockClient.get("${url.listManga}$pageNumber"))
          .thenAnswer((_) async => Future.value(
                http.Response(fixture('genre'), 200),
              ));

      var result = await apiProvider.getListManga(pageNumber);
      expect(result, isA<PaginatedManga>());
    });

    test('Fail test list manga', () async {
      when(mockClient.get("${url.listManga}$pageNumber")).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getListManga(pageNumber), throwsException);
    });
  });

  group("List Manhua Test", () {
    int pageNumber = 1;

    test('Get list manhua', () async {
      when(mockClient.get("${url.listManhua}$pageNumber"))
          .thenAnswer((_) async => Future.value(
                http.Response(fixture('genre'), 200),
              ));

      var result = await apiProvider.getListManhua(pageNumber);
      expect(result, isA<PaginatedManga>());
    });

    test('Fail test list manhua', () async {
      when(mockClient.get("${url.listManhua}$pageNumber")).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getListManhua(pageNumber), throwsException);
    });
  });

  group("List Manhwa Test", () {
    int pageNumber = 1;

    test('Get list manhwa', () async {
      when(mockClient.get("${url.listManhwa}$pageNumber"))
          .thenAnswer((_) async => Future.value(
                http.Response(fixture('genre'), 200),
              ));

      var result = await apiProvider.getListManhwa(pageNumber);
      expect(result, isA<PaginatedManga>());
    });

    test('Fail test list manhwa', () async {
      when(mockClient.get("${url.listManhwa}$pageNumber")).thenAnswer(
          (_) async => Future.value(http.Response('"message": "error"', 404)));
      expect(apiProvider.getListManhwa(pageNumber), throwsException);
    });
  });
}
