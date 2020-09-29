import 'package:moor_flutter/moor_flutter.dart';

import '../../model/bookmark/bookmark_model.dart';
import '../../model/history/history_model.dart';
import '../../provider/local/moor_db_provider.dart';

class MoorDBRepository {
  // Bookmark Table Repo
  Future<List<BookmarkModel>> listAllBookmark(int limit, {int offset}) =>
      moorDBProvider.bookmarkDao.listAllBookmark(limit, offset: offset);
  Stream<List<BookmarkModel>> watchAllBookmark() =>
      moorDBProvider.bookmarkDao.watchAllBookmark();
  Future insertBookmark(Insertable<Bookmark> bookmark) =>
      moorDBProvider.bookmarkDao.insertBookmark(bookmark);
  Future updateBookmark(Insertable<Bookmark> bookmark) =>
      moorDBProvider.bookmarkDao.updateBookmark(bookmark);
  Future deleteBookmark(Insertable<Bookmark> bookmark) =>
      moorDBProvider.bookmarkDao.deleteBookmark(bookmark);
  Future<List<BookmarkModel>> searchBookmarkByQuery(String query) =>
      moorDBProvider.bookmarkDao.searchBookmarkByQuery(query);

  // History Table Repo
  Future<List<HistoryModel>> listAllHistory(int limit, {int offset}) =>
      moorDBProvider.historyDao.listAllHistory(limit, offset: offset);
  Stream<List<HistoryModel>> watchAllHistory() =>
      moorDBProvider.historyDao.watchAllHistory();
  Future insertHistory(Insertable<History> history) =>
      moorDBProvider.historyDao.insertHistory(history);
  Future updateHistory(Insertable<History> history) =>
      moorDBProvider.historyDao.updateHistory(history);
  Future deleteHistory(Insertable<History> history) =>
      moorDBProvider.historyDao.deleteHistory(history);
  Future<List<HistoryModel>> searchHistoryByQuery(String query) =>
      moorDBProvider.historyDao.searchHistoryByQuery(query);
}
