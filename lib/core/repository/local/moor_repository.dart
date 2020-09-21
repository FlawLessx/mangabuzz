import 'package:moor_flutter/moor_flutter.dart';

import '../../model/bookmark/bookmark_model.dart';
import '../../model/history/history_model.dart';
import '../../provider/local/moor_db_provider.dart';

class MoorDBRepository {
  final _bookmark = MyDatabase().bookmarkDao;
  final _history = MyDatabase().historyDao;

  // Bookmark Table Repo
  Future<List<BookmarkModel>> listAllBookmark() => _bookmark.listAllBookmark();
  Stream<List<BookmarkModel>> watchAllBookmark() =>
      _bookmark.watchAllBookmark();
  Future insertBookmark(Insertable<Bookmark> bookmark) =>
      _bookmark.insertBookmark(bookmark);
  Future updateBookmark(Insertable<Bookmark> bookmark) =>
      _bookmark.updateBookmark(bookmark);
  Future deleteBookmark(Insertable<Bookmark> bookmark) =>
      _bookmark.deleteBookmark(bookmark);
  Future<List<BookmarkModel>> searchBookmarkByQuery(String query) =>
      _bookmark.searchBookmarkByQuery(query);

  // History Table Repo
  Future<List<HistoryModel>> listAllHistory() => _history.listAllHistory();
  Stream<List<HistoryModel>> watchAllHistory() => _history.watchAllHistory();
  Future insertHistory(Insertable<History> history) =>
      _history.insertHistory(history);
  Future updateHistory(Insertable<History> history) =>
      _history.updateHistory(history);
  Future deleteHistory(Insertable<History> history) =>
      _history.deleteHistory(history);
  Future<List<HistoryModel>> searchHistoryByQuery(String query) =>
      _history.searchHistoryByQuery(query);
}
