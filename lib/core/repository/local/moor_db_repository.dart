import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as paths;

part 'moor_db_repository.g.dart';

class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get mangaEndpoint => text()();
  TextColumn get image => text()();
  TextColumn get author => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get rating => text().nullable()();
  TextColumn get description => text().nullable()();
}

class Historys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get mangaEndpoint => text()();
  TextColumn get image => text()();
  TextColumn get author => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get rating => text().nullable()();
  IntColumn get chapterReached => integer().nullable()();
  IntColumn get totalChapter => integer().nullable()();
}

@UseMoor(tables: [Bookmarks, Historys], daos: [BookmarkDao, HistoryDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

//
// Constructor
//

MyDatabase constructDb({bool logStatements = false}) {
  final executor = LazyDatabase(() async {
    final dataDir = await paths.getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dataDir.path, 'db.sqlite'));
    return VmDatabase(dbFile, logStatements: logStatements);
  });
  return MyDatabase(executor);
}

//
// DAOs
//

@UseDao(tables: [Bookmarks])
class BookmarkDao extends DatabaseAccessor<MyDatabase> with _$BookmarkDaoMixin {
  final MyDatabase db;

  BookmarkDao(this.db) : super(db);

  //
  // Bookmark Table
  //

  // Get all data from bookmarks table
  Future<List<Bookmark>> listAllBookmark() => select(bookmarks).get();
  // Emit elements when the watched data changes
  Stream<List<Bookmark>> wacthAllBookmark() => select(bookmarks).watch();
  // Insert operation
  Future insertBookmark(Insertable<Bookmark> bookmark) =>
      into(bookmarks).insert(bookmark);
  // Update operation
  Future updateBookmark(Insertable<Bookmark> bookmark) =>
      update(bookmarks).replace(bookmark);
  // Delete operation
  Future deleteBookmark(Insertable<Bookmark> bookmark) =>
      delete(bookmarks).delete(bookmark);
  // Search Operation
  Future<List<Bookmark>> searchByQuery(String query) {
    return (select(bookmarks)..where((tbl) => tbl.title.equals(query))).get();
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
  Future<List<History>> listAllHistory() => select(historys).get();
  // Emit elements when the watched data changes
  Stream<List<History>> wacthAllHistory() => select(historys).watch();
  // Insert operation
  Future insertHistory(Insertable<History> history) =>
      into(historys).insert(history);
  // Update operation
  Future updateHistory(Insertable<History> history) =>
      update(historys).replace(history);
  // Delete operation
  Future deleteHistory(Insertable<History> history) =>
      delete(historys).delete(history);
  // Search Operation
  Future<List<History>> searchByQuery(String query) {
    return (select(historys)..where((tbl) => tbl.title.equals(query))).get();
  }
}
