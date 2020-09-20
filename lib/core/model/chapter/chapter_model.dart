import 'dart:convert';

List<Chapter> chapterFromJson(String str) =>
    List<Chapter>.from(json.decode(str).map((x) => Chapter.fromJson(x)));

String chapterToJson(List<Chapter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chapter {
  Chapter({
    this.indexImage,
    this.imageLink,
  });

  final String indexImage;
  final String imageLink;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        indexImage: json["indexImage"],
        imageLink: json["imageLink"],
      );

  Map<String, dynamic> toJson() => {
        "indexImage": indexImage,
        "imageLink": imageLink,
      };
}
