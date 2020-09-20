// To parse this JSON data, do
//
//     final mangaDetail = mangaDetailFromJson(jsonString);

import 'dart:convert';

MangaDetail mangaDetailFromJson(String str) =>
    MangaDetail.fromJson(json.decode(str));

String mangaDetailToJson(MangaDetail data) => json.encode(data.toJson());

class MangaDetail {
  MangaDetail({
    this.title,
    this.mangaEndpoint,
    this.image,
    this.status,
    this.released,
    this.author,
    this.type,
    this.rating,
    this.lastUpdated,
    this.description,
    this.genreList,
    this.chapterList,
  });

  final String title;
  final String mangaEndpoint;
  final String image;
  final String status;
  final String released;
  final String author;
  final String type;
  final String rating;
  final String lastUpdated;
  final String description;
  final List<GenreList> genreList;
  final List<ChapterList> chapterList;

  factory MangaDetail.fromJson(Map<String, dynamic> json) => MangaDetail(
        title: json["title"],
        mangaEndpoint: json["mangaEndpoint"],
        image: json["image"],
        status: json["status"],
        released: json["released"],
        author: json["author"],
        type: json["type"],
        rating: json["rating"],
        lastUpdated: json["lastUpdated"],
        description: json["description"],
        genreList: List<GenreList>.from(
            json["genreList"].map((x) => GenreList.fromJson(x))),
        chapterList: List<ChapterList>.from(
            json["chapterList"].map((x) => ChapterList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "mangaEndpoint": mangaEndpoint,
        "image": image,
        "status": status,
        "released": released,
        "author": author,
        "type": type,
        "rating": rating,
        "lastUpdated": lastUpdated,
        "description": description,
        "genreList": List<dynamic>.from(genreList.map((x) => x.toJson())),
        "chapterList": List<dynamic>.from(chapterList.map((x) => x.toJson())),
      };
}

class ChapterList {
  ChapterList({
    this.chapterName,
    this.chapterEndpoint,
    this.chapterDownload,
  });

  final String chapterName;
  final String chapterEndpoint;
  final String chapterDownload;

  factory ChapterList.fromJson(Map<String, dynamic> json) => ChapterList(
        chapterName: json["chapterName"],
        chapterEndpoint: json["chapter_endpoint"],
        chapterDownload: json["chapterDownload"],
      );

  Map<String, dynamic> toJson() => {
        "chapterName": chapterName,
        "chapter_endpoint": chapterEndpoint,
        "chapterDownload": chapterDownload,
      };
}

class GenreList {
  GenreList({
    this.genreName,
    this.genreEndpoint,
  });

  final String genreName;
  final String genreEndpoint;

  factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
        genreName: json["genreName"],
        genreEndpoint: json["genre_endpoint"],
      );

  Map<String, dynamic> toJson() => {
        "genreName": genreName,
        "genre_endpoint": genreEndpoint,
      };
}
