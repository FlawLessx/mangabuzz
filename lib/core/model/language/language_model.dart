import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Language {
  final int id;
  final String langguangeName;
  final Locale locale;

  Language(
      {@required this.id,
      @required this.langguangeName,
      @required this.locale});

  static List<Language> languageList = [
    Language(id: 0, langguangeName: "English", locale: Locale("en", "US")),
    Language(id: 1, langguangeName: "Indonesia", locale: Locale("id", "ID")),
  ];
}
