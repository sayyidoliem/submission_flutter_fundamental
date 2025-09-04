import 'package:dicoding_submission_flutter_fundamental/data/db/bookmark_db.dart';
import 'package:flutter/foundation.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant.dart';

class BookmarkProvider extends ChangeNotifier {
  final BookmarkDatabase _db = BookmarkDatabase();

  List<Restaurant> _bookmarks = [];
  List<Restaurant> get bookmarks => _bookmarks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BookmarkProvider() {
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    _isLoading = true;
    notifyListeners();

    _bookmarks = await _db.getBookmarks();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addBookmark(Restaurant restaurant) async {
    await _db.insertBookmark(restaurant);
    await loadBookmarks();
  }

  Future<void> removeBookmark(String id) async {
    await _db.deleteBookmark(id);
    await loadBookmarks();
  }

  Future<bool> isBookmarked(String id) async {
    final bookmark = await _db.getBookmarkById(id);
    return bookmark != null;
  }
}
