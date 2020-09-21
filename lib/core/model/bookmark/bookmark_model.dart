// To parse this JSON data, do
//
//     final bookmark = bookmarkFromJson(jsonString);

import 'dart:convert';

List<BookmarkModel> bookmarkFromJson(String str) => List<BookmarkModel>.from(
    json.decode(str).map((x) => BookmarkModel.fromJson(x)));

String bookmarkToJson(List<BookmarkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookmarkModel {
  BookmarkModel({
    this.title,
    this.mangaEndpoint,
    this.image,
    this.author,
    this.type,
    this.rating,
    this.description,
  });

  final String title;
  final String mangaEndpoint;
  final String image;
  final String author;
  final String type;
  final String rating;
  final String description;

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
        title: json["title"],
        mangaEndpoint: json["mangaEndpoint"],
        image: json["image"],
        author: json["author"],
        type: json["type"],
        rating: json["rating"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "mangaEndpoint": mangaEndpoint,
        "image": image,
        "author": author,
        "type": type,
        "rating": rating,
        "description": description,
      };
}
