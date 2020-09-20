// To parse this JSON data, do
//
//     final bestSeries = bestSeriesFromJson(jsonString);

import 'dart:convert';

List<BestSeries> bestSeriesFromJson(String str) =>
    List<BestSeries>.from(json.decode(str).map((x) => BestSeries.fromJson(x)));

String bestSeriesToJson(List<BestSeries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BestSeries {
  BestSeries({
    this.title,
    this.mangaEndpoint,
    this.image,
    this.type,
  });

  final String title;
  final String mangaEndpoint;
  final String image;
  final String type;

  factory BestSeries.fromJson(Map<String, dynamic> json) => BestSeries(
        title: json["title"],
        mangaEndpoint: json["manga_endpoint"],
        image: json["image"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "manga_endpoint": mangaEndpoint,
        "image": image,
        "type": type,
      };
}
