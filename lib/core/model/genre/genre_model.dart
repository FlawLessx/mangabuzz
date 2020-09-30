// To parse this JSON data, do
//
//     final genre = genreFromJson(jsonString);

import 'dart:convert';

List<Genre> genreFromJson(String str) =>
    List<Genre>.from(json.decode(str).map((x) => Genre.fromJson(x)));

String genreToJson(List<Genre> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Genre {
  Genre({
    this.genreTitle,
    this.genreSubtitle,
    this.genreEndpoint,
  });

  final String genreTitle;
  final String genreSubtitle;
  final String genreEndpoint;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        genreTitle: json["genreTitle"],
        genreSubtitle: json["genreSubtitle"],
        genreEndpoint: json["genre_endpoint"],
      );

  Map<String, dynamic> toJson() => {
        "genreTitle": genreTitle,
        "genreSubtitle": genreSubtitle,
        "genre_endpoint": genreEndpoint,
      };
}
