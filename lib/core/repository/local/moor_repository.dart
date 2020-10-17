import '../../model/bookmark/bookmark_model.dart';
import '../../model/history/history_model.dart';
import '../../provider/local/moor_db_provider.dart';
import 'package:mangabuzz/injection_container.dart';

class MoorDBRepository {
  final db = sl.get<MyDatabase>();

  // Bookmark Table Repo
  Future<int> getBookmarkLength() => db.bookmarkDao.getBookmarkLength();
  Future<List<BookmarkModel>> listAllBookmark() =>
      db.bookmarkDao.listAllBookmark();
  Stream<List<BookmarkModel>> watchAllBookmark() =>
      db.bookmarkDao.watchAllBookmark();
  Future insertBookmark(Bookmark bookmark) =>
      db.bookmarkDao.insertBookmark(bookmark);
  Future updateBookmark(Bookmark bookmark) =>
      db.bookmarkDao.updateBookmark(bookmark);
  Future deleteBookmark(String title, String mangaEndpoint) =>
      db.bookmarkDao.deleteBookmark(title, mangaEndpoint);
  Future<BookmarkModel> getBookmark(String title, String mangaEndpoint) =>
      db.bookmarkDao.getBookmark(title, mangaEndpoint);
  Future<List<BookmarkModel>> searchBookmarkByQuery(String query) =>
      db.bookmarkDao.searchBookmarkByQuery(query);

  // History Table Repo
  Future<List<HistoryModel>> listAllHistory() => db.historyDao.listAllHistory();
  Stream<List<HistoryModel>> watchAllHistory() =>
      db.historyDao.watchAllHistory();
  Future insertHistory(History history) => db.historyDao.insertHistory(history);
  Future updateHistory(History history) => db.historyDao.updateHistory(history);
  Future deleteHistory(String title, String mangaEndpoint) =>
      db.historyDao.deleteHistory(title, mangaEndpoint);
  Future<HistoryModel> getHistory(String title, String mangaEndpoint) =>
      db.historyDao.getHistory(title, mangaEndpoint);
  Future<List<HistoryModel>> searchHistoryByQuery(String query) =>
      db.historyDao.searchHistoryByQuery(query);
}
