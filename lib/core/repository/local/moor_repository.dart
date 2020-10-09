import '../../model/bookmark/bookmark_model.dart';
import '../../model/history/history_model.dart';
import '../../provider/local/moor_db_provider.dart';

class MoorDBRepository {
  // Bookmark Table Repo
  Future<List<BookmarkModel>> listAllBookmark(int limit, {int offset}) =>
      moorDBProvider.bookmarkDao.listAllBookmark(limit, offset: offset);
  Stream<List<BookmarkModel>> watchAllBookmark() =>
      moorDBProvider.bookmarkDao.watchAllBookmark();
  Future insertBookmark(Bookmark bookmark) =>
      moorDBProvider.bookmarkDao.insertBookmark(bookmark);
  Future updateBookmark(Bookmark bookmark) =>
      moorDBProvider.bookmarkDao.updateBookmark(bookmark);
  Future deleteBookmark(String title, String mangaEndpoint) =>
      moorDBProvider.bookmarkDao.deleteBookmark(title, mangaEndpoint);
  Future<BookmarkModel> getBookmark(String title, String mangaEndpoint) =>
      moorDBProvider.bookmarkDao.getBookmark(title, mangaEndpoint);
  Future<List<BookmarkModel>> searchBookmarkByQuery(String query) =>
      moorDBProvider.bookmarkDao.searchBookmarkByQuery(query);

  // History Table Repo
  Future<List<HistoryModel>> listAllHistory(int limit, {int offset}) =>
      moorDBProvider.historyDao.listAllHistory(limit, offset: offset);
  Stream<List<HistoryModel>> watchAllHistory() =>
      moorDBProvider.historyDao.watchAllHistory();
  Future insertHistory(History history) =>
      moorDBProvider.historyDao.insertHistory(history);
  Future updateHistory(History history) =>
      moorDBProvider.historyDao.updateHistory(history);
  Future deleteHistory(String title, String mangaEndpoint) =>
      moorDBProvider.historyDao.deleteHistory(title, mangaEndpoint);
  Future<HistoryModel> getHistory(String title, String mangaEndpoint) =>
      moorDBProvider.historyDao.getHistory(title, mangaEndpoint);
  Future<List<HistoryModel>> searchHistoryByQuery(String query) =>
      moorDBProvider.historyDao.searchHistoryByQuery(query);
}
