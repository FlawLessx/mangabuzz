// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_US = {
  "appName": "Mangabuzz",
  "version": "v {}",
  "searchHome": "Search Something...",
  "searchBookmark": "Search Bookmark...",
  "searchHistory": "Search History...",
  "menu": {
    "newest": "Newest",
    "bookmark": "Bookmark",
    "history": "History",
    "settings": "Settings"
  },
  "homePage": {
    "hotSeries": "Hot series update",
    "latestUpdate": "Latest Update"
  },
  "bookmarkPage": {
    "detail": "Detail"
  },
  "percent": "{}%",
  "detail": {
    "chapterList": "Chapter List",
    "download": "Download",
    "chapterReached": "{} Chapter Reached",
    "chapterRemains": "{} Chapter Remains",
    "continueRead": "Continue Read"
  },
  "settings": {
    "settingsName": "Settings",
    "generalSettings": "General Settings",
    "langguange": "Langguage",
    "otherSettings": "Other Settings",
    "clearCache": "Clear cache",
    "sizeCache": "{} MB",
    "infoCache": "Cache is useful for storing and then displaying downloaded images so you don't need to download them again"
  },
  "chapter": {
    "chapterNow": "Chapter {}",
    "chapterRemains": "From {} chapter"
  },
  "listManga": "List Manga",
  "listManhua": "List Manhua",
  "listManhwa": "List Manhwa",
  "searchQuery": "Result for {}"
};
static const Map<String,dynamic> id_ID = {
  "appName": "Mangabuzz",
  "version": "v {}",
  "searchHome": "Cari Sesuatu...",
  "searchBookmark": "Cari Bookmark...",
  "searchHistory": "Cari Riwayat...",
  "menu": {
    "newest": "Terbaru",
    "bookmark": "Ditandai",
    "history": "History",
    "settings": "Pengaturan"
  },
  "homePage": {
    "hotSeries": "Pembaruan Seri Populer",
    "latestUpdate": "Update Terakhir"
  },
  "bookmarkPage": {
    "detail": "Selengkapnya"
  },
  "percent": "{}%",
  "detail": {
    "chapterList": "List Chapter",
    "download": "Unduh",
    "chapterReached": "{} Chapter Dicapai",
    "chapterRemains": "{} Chapter Tersista",
    "continueRead": "Lanjutkan Membaca"
  },
  "settings": {
    "settingsName": "Pengaturan",
    "generalSettings": "Pengaturan Umum",
    "langguange": "Bahasa",
    "otherSettings": "Pengaturan Lainnya",
    "clearCache": "Bersihkan Cache",
    "sizeCache": "{} MB",
    "infoCache": "Cache berguna untuk menyimpan lalu menampilkan gambar yang sudah terunduh sehingga tidak perlu mengunduh lagi"
  },
  "chapter": {
    "chapterNow": "Chapter {}",
    "chapterRemains": "Dari {} chapter"
  },
  "listManga": "List Manga",
  "listManhua": "List Manhua",
  "listManhwa": "List Manhwa",
  "searchQuery": "Hasil untuk {}"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US, "id_ID": id_ID};
}
