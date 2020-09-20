// To parse this JSON data, do
//
//     final allGenre = allGenreFromJson(jsonString);

import 'dart:convert';

List<AllGenre> allGenreFromJson(String str) =>
    List<AllGenre>.from(json.decode(str).map((x) => AllGenre.fromJson(x)));

String allGenreToJson(List<AllGenre> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllGenre {
  AllGenre({
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

  factory AllGenre.fromJson(Map<String, dynamic> json) => AllGenre(
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
