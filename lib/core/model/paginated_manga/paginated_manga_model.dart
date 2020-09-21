// To parse this JSON data, do
//
//     final paginatedManga = paginatedMangaFromJson(jsonString);

import 'dart:convert';

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
  final List<Result> result;

  factory PaginatedManga.fromJson(Map<String, dynamic> json) => PaginatedManga(
        previousPage: json["previousPage"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "previousPage": previousPage,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.title,
    this.mangaEndpoint,
    this.type,
    this.image,
    this.chapter,
    this.rating,
  });

  final String title;
  final String mangaEndpoint;
  final String type;
  final String image;
  final String chapter;
  final String rating;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        mangaEndpoint: json["manga_endpoint"],
        type: json["type"],
        image: json["image"],
        chapter: json["chapter"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "manga_endpoint": mangaEndpoint,
        "type": type,
        "image": image,
        "chapter": chapter,
        "rating": rating,
      };
}
