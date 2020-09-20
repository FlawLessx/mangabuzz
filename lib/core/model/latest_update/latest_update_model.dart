// To parse this JSON data, do
//
//     final latestUpdate = latestUpdateFromJson(jsonString);

import 'dart:convert';

List<LatestUpdate> latestUpdateFromJson(String str) => List<LatestUpdate>.from(
    json.decode(str).map((x) => LatestUpdate.fromJson(x)));

String latestUpdateToJson(List<LatestUpdate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestUpdate {
  LatestUpdate({
    this.title,
    this.mangaEndpoint,
    this.image,
    this.hotTag,
    this.newTag,
    this.listNewChapter,
  });

  final String title;
  final String mangaEndpoint;
  final String image;
  final String hotTag;
  final String newTag;
  final List<ListNewChapter> listNewChapter;

  factory LatestUpdate.fromJson(Map<String, dynamic> json) => LatestUpdate(
        title: json["title"],
        mangaEndpoint: json["manga_endpoint"],
        image: json["image"],
        hotTag: json["hotTag"],
        newTag: json["newTag"],
        listNewChapter: List<ListNewChapter>.from(
            json["listNewChapter"].map((x) => ListNewChapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "manga_endpoint": mangaEndpoint,
        "image": image,
        "hotTag": hotTag,
        "newTag": newTag,
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
