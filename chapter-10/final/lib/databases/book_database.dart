import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseBooks {

  late var database;

  initDB() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'books.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE books(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },

      version: 1,
    );
  }
  Future<void> insertBook(data) async {
    final db = await database;

    await db.insert(
      'books',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<dynamic>> getBooks() async {
    final db = await database;

    final List<Map<String, Object?>> books = await db.query('books');

    return books;
  }
}
