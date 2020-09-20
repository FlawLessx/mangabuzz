// To parse this JSON data, do
//
//     final manga = mangaFromJson(jsonString);

import 'dart:convert';

List<Manga> mangaFromJson(String str) =>
    List<Manga>.from(json.decode(str).map((x) => Manga.fromJson(x)));

String mangaToJson(List<Manga> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Manga {
  Manga({
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

  factory Manga.fromJson(Map<String, dynamic> json) => Manga(
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
