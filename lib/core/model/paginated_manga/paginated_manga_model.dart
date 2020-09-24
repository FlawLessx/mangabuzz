// To parse this JSON data, do
//
//     final paginatedManga = paginatedMangaFromJson(jsonString);

import 'dart:convert';

import 'package:mangabuzz/core/model/manga/manga_model.dart';

PaginatedManga paginatedMangaFromJson(String str) =>
    PaginatedManga.fromJson(json.decode(str));

String paginatedMangaToJson(PaginatedManga data) => json.encode(data.toJson());

class PaginatedManga {
  PaginatedManga({
    this.previousPage,
    this.currentPage,
    this.nextPage,
    this.result,
  });

  final int previousPage;
  final int currentPage;
  final int nextPage;
  final List<Manga> result;

  factory PaginatedManga.fromJson(Map<String, dynamic> json) => PaginatedManga(
        previousPage: json["previousPage"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        result: List<Manga>.from(json["result"].map((x) => Manga.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "previousPage": previousPage,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}
