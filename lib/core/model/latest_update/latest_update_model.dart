// To parse this JSON data, do
//
//     final latestUpdate = latestUpdateFromJson(jsonString);

import 'dart:convert';

LatestUpdate latestUpdateFromJson(String str) =>
    LatestUpdate.fromJson(json.decode(str));

String latestUpdateToJson(LatestUpdate data) => json.encode(data.toJson());

class LatestUpdate {
  LatestUpdate({
    this.previousPage,
    this.currentPage,
    this.nextPage,
    this.latestUpdateList,
  });

  final int previousPage;
  final int currentPage;
  final int nextPage;
  final List<LatestUpdateList> latestUpdateList;

  factory LatestUpdate.fromJson(Map<String, dynamic> json) => LatestUpdate(
        previousPage: json["previousPage"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        latestUpdateList: List<LatestUpdateList>.from(
            json["latestUpdateList"].map((x) => LatestUpdateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "previousPage": previousPage,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "latestUpdateList":
            List<dynamic>.from(latestUpdateList.map((x) => x.toJson())),
      };
}

class LatestUpdateList {
  LatestUpdateList({
    this.title,
    this.mangaEndpoint,
    this.image,
    this.hotTag,
    this.type,
    this.listNewChapter,
  });

  final String title;
  final String mangaEndpoint;
  final String image;
  final String hotTag;
  final String type;
  final List<ListNewChapter> listNewChapter;

  factory LatestUpdateList.fromJson(Map<String, dynamic> json) =>
      LatestUpdateList(
        title: json["title"],
        mangaEndpoint: json["manga_endpoint"],
        image: json["image"],
        hotTag: json["hotTag"],
        type: json["type"],
        listNewChapter: List<ListNewChapter>.from(
            json["listNewChapter"].map((x) => ListNewChapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "manga_endpoint": mangaEndpoint,
        "image": image,
        "hotTag": hotTag,
        "type": type,
        "listNewChapter":
            List<dynamic>.from(listNewChapter.map((x) => x.toJson())),
      };
}

class ListNewChapter {
  ListNewChapter({
    this.chapterName,
    this.chapterEndpoint,
    this.updatedOn,
  });

  final String chapterName;
  final String chapterEndpoint;
  final String updatedOn;

  factory ListNewChapter.fromJson(Map<String, dynamic> json) => ListNewChapter(
        chapterName: json["chapterName"],
        chapterEndpoint: json["chapter_endpoint"],
        updatedOn: json["updatedOn"],
      );

  Map<String, dynamic> toJson() => {
        "chapterName": chapterName,
        "chapter_endpoint": chapterEndpoint,
        "updatedOn": updatedOn,
      };
}
