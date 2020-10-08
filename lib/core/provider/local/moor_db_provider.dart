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
  IntColumn get totalChapter => integer()();
  BoolColumn get isNew => boolean().nullable()();

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
  Future<List<BookmarkModel>> listAllBookmark(int limit, {int offset}) {
    try {
      return (select(bookmarks)..limit(limit, offset: offset)).map((rows) {
        return BookmarkModel(
            title: rows.title,
            mangaEndpoint: rows.mangaEndpoint,
            image: rows.image,
            author: rows.author,
            type: rows.type,
            rating: rows.rating,
            description: rows.description,
            totalChapter: rows.totalChapter,
            isNew: rows.isNew);
      }).get();
    } catch (e) {
      throw Exception(e.toString());
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
              description: e.description,
              totalChapter: e.totalChapter,
              isNew: e.isNew);
        }).toList();
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Insert operation
  Future<int> insertBookmark(Bookmark bookmark) {
    try {
      return into(bookmarks).insert(bookmark);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Update operation
  Future updateBookmark(Bookmark bookmark) {
    try {
      return update(bookmarks).replace(bookmark);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Delete operation
  Future<int> deleteBookmark(String title, String mangaEndpoint) {
    try {
      return (delete(bookmarks)
            ..where((tbl) =>
                tbl.title.equals(title) &
                tbl.mangaEndpoint.equals(mangaEndpoint)))
          .go();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get bookmark data by title & mangaEndpoint
  Future<BookmarkModel> getBookmark(String title, String mangaEndpoint) {
    try {
      final query = (select(bookmarks)
        ..where((t) =>
            t.title.equals(title) & t.mangaEndpoint.equals(mangaEndpoint)));

      return query.map((rows) {
        return BookmarkModel(
            title: rows.title,
            mangaEndpoint: rows.mangaEndpoint,
            image: rows.image,
            author: rows.author,
            type: rows.type,
            rating: rows.rating,
            description: rows.description,
            totalChapter: rows.totalChapter,
            isNew: rows.isNew);
      }).getSingle();
    } catch (e) {
      throw Exception(e.toString());
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
            description: rows.description,
            totalChapter: rows.totalChapter,
            isNew: rows.isNew);
      }).get();
    } catch (e) {
      throw Exception(e.toString());
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
  Future<List<HistoryModel>> listAllHistory(int limit, {int offset}) {
    try {
      return (select(historys)..limit(limit, offset: offset)).map((rows) {
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
    } catch (e) {
      throw Exception(e.toString());
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
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Insert operation
  Future insertHistory(HistorysCompanion history) {
    try {
      return into(historys).insert(history);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Update operation
  Future updateHistory(HistorysCompanion history) {
    try {
      return update(historys).replace(history);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Delete operation
  Future deleteHistory(String title, String mangaEndpoint) {
    try {
      return (delete(historys)
            ..where((tbl) =>
                tbl.title.equals(title) &
                tbl.mangaEndpoint.equals(mangaEndpoint)))
          .go();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get history data by title & mangaEndpoint
  Future<HistoryModel> getHistory(String title, String mangaEndpoint) {
    try {
      final query = (select(historys)
        ..where((t) =>
            t.title.equals(title) & t.mangaEndpoint.equals(mangaEndpoint)));

      return query.map((rows) {
        return HistoryModel(
            title: rows.title,
            mangaEndpoint: rows.mangaEndpoint,
            image: rows.image,
            author: rows.author,
            type: rows.type,
            rating: rows.rating,
            chapterReached: rows.chapterReached,
            totalChapter: rows.totalChapter);
      }).getSingle();
    } catch (e) {
      throw Exception(e.toString());
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
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

// Call Database
final moorDBProvider = MyDatabase();
