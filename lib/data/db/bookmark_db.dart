import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BookmarkDatabase {
  static final BookmarkDatabase _instance = BookmarkDatabase._internal();
  static Database? _database;

  static const String _tableName = 'bookmarks';

  BookmarkDatabase._internal();

  factory BookmarkDatabase() => _instance;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bookmark.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            city TEXT,
            pictureId TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> insertBookmark(Restaurant restaurant) async {
    final db = await database;
    await db.insert(_tableName, {
      'id': restaurant.id,
      'name': restaurant.name,
      'description': restaurant.description,
      'city': restaurant.city,
      'pictureId': restaurant.pictureId,
      'rating': restaurant.rating,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Restaurant>> getBookmarks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return maps.map((map) {
      return Restaurant(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        city: map['city'],
        pictureId: map['pictureId'],
        rating: map['rating'],
        address: null,
        menus: null,
      );
    }).toList();
  }

  Future<Restaurant?> getBookmarkById(String id) async {
    final db = await database;
    final maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      final map = maps.first;
      return Restaurant(
        id: map['id'] as String,
        name: map['name'] as String,
        description: map['description'] as String,
        city: map['city'] as String,
        pictureId: map['pictureId'] as String,
        rating: map['rating'] is double
            ? map['rating'] as double
            : (map['rating'] as num).toDouble(),
        address: null,
        menus: null,
      );
    }
    return null;
  }

  Future<int> deleteBookmark(String id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
