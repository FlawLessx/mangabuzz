import 'package:mangabuzz/core/provider/local/moor_db_provider.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:test/test.dart';

void main() {
  MyDatabase _db;

  setUp(() {
    _db = MyDatabase();
  });

  tearDown(() async {
    await _db.close();
  });

  group("Bookmark Group Test", () {
    test('bookmark can be created & search', () async {
      await _db.bookmarkDao.insertBookmark(BookmarksCompanion(
          title: Value('One Piece'),
          mangaEndpoint: Value('one-piece/'),
          image: Value('imge')));
      final result = await _db.bookmarkDao.searchBookmarkByQuery('One Piece');

      expect(result.first.title, 'One Piece');
    });

    test('bookmark can be deleted', () async {
      await _db.bookmarkDao.deleteBookmark(BookmarksCompanion(
          title: Value('One Piece'),
          mangaEndpoint: Value('one-piece/'),
          image: Value('imge')));
      final result = await _db.bookmarkDao.listAllBookmark();

      expect(result.length, 0);
    });
  });

  group("History Group Test", () {
    test('history can be created & search', () async {
      await _db.historyDao.insertHistory(HistorysCompanion(
          title: Value('One Piece'),
          mangaEndpoint: Value('one-piece/'),
          image: Value('imge')));
      final result = await _db.historyDao.searchHistoryByQuery('One Piece');

      expect(result.first.title, 'One Piece');
    });

    test('history can be deleted', () async {
      await _db.historyDao.deleteHistory(HistorysCompanion(
          title: Value('One Piece'),
          mangaEndpoint: Value('one-piece/'),
          image: Value('imge')));
      final result = await _db.bookmarkDao.listAllBookmark();

      expect(result.length, 0);
    });
  });
}
