import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseBooks{
  late Future<Database> database;

  getDataBase() async {
    return openDatabase(
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
    final db = await getDataBase();
    await db.insert(
      'books',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<dynamic>> getBooks() async {
    final db = await getDataBase();
    final List<Map<String, Object?>> books = await db.query('books');
    return books;
  }

  Future<int?> getCountBooks() async {
    final db = await getDataBase();
    var value = await db.rawQuery('SELECT COUNT(*) FROM books');
    int? count = Sqflite.firstIntValue(value);

    return count;
  }
}
