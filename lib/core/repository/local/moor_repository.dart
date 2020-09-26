import 'package:moor_flutter/moor_flutter.dart';

import '../../model/bookmark/bookmark_model.dart';
import '../../model/history/history_model.dart';
import '../../provider/local/moor_db_provider.dart';

class MoorDBRepository {
  var _moorDB = MyDatabase();

  // Bookmark Table Repo
  Future<List<BookmarkModel>> listAllBookmark() =>
      _moorDB.bookmarkDao.listAllBookmark();
  Stream<List<BookmarkModel>> watchAllBookmark() =>
      _moorDB.bookmarkDao.watchAllBookmark();
  Future insertBookmark(Insertable<Bookmark> bookmark) =>
      _moorDB.bookmarkDao.insertBookmark(bookmark);
  Future updateBookmark(Insertable<Bookmark> bookmark) =>
      _moorDB.bookmarkDao.updateBookmark(bookmark);
  Future deleteBookmark(Insertable<Bookmark> bookmark) =>
      _moorDB.bookmarkDao.deleteBookmark(bookmark);
  Future<List<BookmarkModel>> searchBookmarkByQuery(String query) =>
      _moorDB.bookmarkDao.searchBookmarkByQuery(query);

  // History Table Repo
  Future<List<HistoryModel>> listAllHistory() =>
      _moorDB.historyDao.listAllHistory();
  Stream<List<HistoryModel>> watchAllHistory() =>
      _moorDB.historyDao.watchAllHistory();
  Future insertHistory(Insertable<History> history) =>
      _moorDB.historyDao.insertHistory(history);
  Future updateHistory(Insertable<History> history) =>
      _moorDB.historyDao.updateHistory(history);
  Future deleteHistory(Insertable<History> history) =>
      _moorDB.historyDao.deleteHistory(history);
  Future<List<HistoryModel>> searchHistoryByQuery(String query) =>
      _moorDB.historyDao.searchHistoryByQuery(query);
}
