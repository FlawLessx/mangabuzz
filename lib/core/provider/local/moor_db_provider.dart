import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../model/bookmark/bookmark_model.dart';
import '../../model/history/history_model.dart';

part 'moor_db_provider.g.dart';

class Bookmarks extends Table {
  TextColumn get title => text()();
  TextColumn get mangaEndpoint => text()();
  TextColumn get image => text()();
  TextColumn get author => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get rating => text().nullable()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {title};
}

class Historys extends Table {
  TextColumn get title => text()();
  TextColumn get mangaEndpoint => text()();
  TextColumn get image => text()();
  TextColumn get author => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get rating => text().nullable()();
  IntColumn get chapterReached => integer().nullable()();
  IntColumn get totalChapter => integer().nullable()();

  @override
  Set<Column> get primaryKey => {title};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

//
// This connection only for testing
//
LazyDatabase _testConnection() {
  return LazyDatabase(() async {
    return VmDatabase.memory();
  });
}

@UseMoor(tables: [Bookmarks, Historys], daos: [BookmarkDao, HistoryDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

//
//  Extension
//
extension DomainToMoorExtension on BookmarkModel {
  Bookmark get asMoor => Bookmark(
      title: title,
      mangaEndpoint: mangaEndpoint,
      image: image,
      author: author,
      type: type,
      rating: rating,
      description: description);
}

extension MoorToDomainExtension on Bookmark {
  BookmarkModel get asDomain => BookmarkModel(
      title: title,
      mangaEndpoint: mangaEndpoint,
      image: image,
      author: author,
      type: type,
      rating: rating,
      description: description);
}

//
// DAOs, This is the repo for the database
//

@UseDao(tables: [Bookmarks])
class BookmarkDao extends DatabaseAccessor<MyDatabase> with _$BookmarkDaoMixin {
  final MyDatabase db;

  BookmarkDao(this.db) : super(db);

  //
  // Bookmark Table
  //

  // Get all data from bookmarks table
  Future<List<BookmarkModel>> listAllBookmark() {
    try {
      return select(bookmarks).map((rows) {
        return BookmarkModel(
            title: rows.title,
            mangaEndpoint: rows.mangaEndpoint,
            image: rows.image,
            author: rows.author,
            type: rows.type,
            rating: rows.rating,
            description: rows.description);
      }).get();
    } on Exception {
      throw Exception();
    }
  }

  // Emit elements when the watched data changes
  Stream<List<BookmarkModel>> watchAllBookmark() {
    try {
      return select(bookmarks).watch().map((rows) {
        return rows.map((e) {
          return BookmarkModel(
              title: e.title,
              mangaEndpoint: e.mangaEndpoint,
              image: e.image,
              author: e.author,
              type: e.type,
              rating: e.rating,
              description: e.description);
        }).toList();
      });
    } on Exception {
      throw Exception();
    }
  }

  // Insert operation
  Future insertBookmark(Insertable<Bookmark> bookmark) {
    try {
      return into(bookmarks).insert(bookmark);
    } on Exception {
      throw Exception();
    }
  }

  // Update operation
  Future updateBookmark(Insertable<Bookmark> bookmark) {
    try {
      return update(bookmarks).replace(bookmark);
    } on Exception {
      throw Exception();
    }
  }

  // Delete operation
  Future deleteBookmark(Insertable<Bookmark> bookmark) {
    try {
      return delete(bookmarks).delete(bookmark);
    } on Exception {
      throw Exception();
    }
  }

  // Search Operation
  Future<List<BookmarkModel>> searchBookmarkByQuery(String query) {
    try {
      return (select(bookmarks)..where((tbl) => tbl.title.contains(query)))
          .map((rows) {
        return BookmarkModel(
            title: rows.title,
            mangaEndpoint: rows.mangaEndpoint,
            image: rows.image,
            author: rows.author,
            type: rows.type,
            rating: rows.rating,
            description: rows.description);
      }).get();
    } on Exception {
      throw Exception();
    }
  }
}

@UseDao(tables: [Historys])
class HistoryDao extends DatabaseAccessor<MyDatabase> with _$HistoryDaoMixin {
  final MyDatabase db;

  HistoryDao(this.db) : super(db);

  //
  // History Table
  //

  // Get all data from bookmarks table
  Future<List<HistoryModel>> listAllHistory() {
    try {
      return select(historys).map((rows) {
        return HistoryModel(
            title: rows.title,
            mangaEndpoint: rows.mangaEndpoint,
            image: rows.image,
            author: rows.author,
            type: rows.type,
            rating: rows.rating,
            chapterReached: rows.chapterReached,
            totalChapter: rows.totalChapter);
      }).get();
    } on Exception {
      throw Exception();
    }
  }

  // Emit elements when the watched data changes
  Stream<List<HistoryModel>> watchAllHistory() {
    try {
      return select(historys).watch().map((rows) {
        return rows.map((e) {
          return HistoryModel(
              title: e.title,
              mangaEndpoint: e.mangaEndpoint,
              image: e.image,
              author: e.author,
              type: e.type,
              rating: e.rating,
              chapterReached: e.chapterReached,
              totalChapter: e.totalChapter);
        }).toList();
      });
    } on Exception {
      throw Exception();
    }
  }

  // Insert operation
  Future insertHistory(Insertable<History> history) {
    try {
      return into(historys).insert(history);
    } on Exception {
      throw Exception();
    }
  }

  // Update operation
  Future updateHistory(Insertable<History> history) {
    try {
      return update(historys).replace(history);
    } on Exception {
      throw Exception();
    }
  }

  // Delete operation
  Future deleteHistory(Insertable<History> history) {
    try {
      return delete(historys).delete(history);
    } on Exception {
      throw Exception();
    }
  }

  // Search Operation
  Future<List<HistoryModel>> searchHistoryByQuery(String query) {
    try {
      return (select(historys)..where((tbl) => tbl.title.contains(query)))
          .map((rows) {
        return HistoryModel(
            title: rows.title,
            mangaEndpoint: rows.mangaEndpoint,
            image: rows.image,
            author: rows.author,
            type: rows.type,
            rating: rows.rating,
            chapterReached: rows.chapterReached,
            totalChapter: rows.totalChapter);
      }).get();
    } on Exception {
      throw Exception();
    }
  }
}
