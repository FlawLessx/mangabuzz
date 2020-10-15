import 'package:moor_flutter/moor_flutter.dart';

class Language {
  final int id;
  final String langguangeName;
  final String languageCode;

  Language(
      {@required this.id,
      @required this.langguangeName,
      @required this.languageCode});

  static List<Language> languageList = [
    Language(id: 0, langguangeName: "English", languageCode: "en"),
    Language(id: 1, langguangeName: "Indonesia", languageCode: "id"),
  ];
}
