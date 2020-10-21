import 'dart:convert';

List<Chapter> chapterFromJson(String str) =>
    List<Chapter>.from(json.decode(str).map((x) => Chapter.fromJson(x)));

String chapterToJson(List<Chapter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chapter {
  Chapter({
    this.imageLink,
  });

  final String imageLink;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        imageLink: json["imageLink"],
      );

  Map<String, dynamic> toJson() => {
        "imageLink": imageLink,
      };
}
