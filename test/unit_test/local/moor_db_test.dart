import 'package:mangabuzz/core/provider/local/moor_db_provider.dart';
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
      await _db.bookmarkDao.insertBookmark(Bookmark(
          title: 'One Piece',
          mangaEndpoint: 'one-piece/',
          image: 'imge',
          totalChapter: 900));
      final result = await _db.bookmarkDao.searchBookmarkByQuery('One Piece');

      expect(result.first.title, 'One Piece');
    });

    test('bookmark can be deleted', () async {
      await _db.bookmarkDao.deleteBookmark("One Piece", "one-piece/");
      final result = await _db.bookmarkDao.listAllBookmark(5, offset: 0);

      expect(result.length, 0);
    });
  });

  group("History Group Test", () {
    test('history can be created & search', () async {
      await _db.historyDao.insertHistory(History(
          title: 'One Piece', mangaEndpoint: 'one-piece/', image: 'imge'));
      final result = await _db.historyDao.searchHistoryByQuery('One Piece');

      expect(result.first.title, 'One Piece');
    });

    test('history can be deleted', () async {
      await _db.historyDao.deleteHistory("One Piece", "one-piece/");
      final result = await _db.bookmarkDao.listAllBookmark(5, offset: 0);

      expect(result.length, 0);
    });
  });
}
